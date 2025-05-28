package engine

import "core:mem"
import "core:debug/trace"
import "base:intrinsics"
import "base:runtime"
import "vendor:webp"

@private webp_config :: union {
    webp.WebPDecoderConfig,
    webp.WebPAnimDecoderOptions,
}

@private webp_decoder_in :: struct {
    input_data:[]u8,
    anim_dec:^webp.WebPAnimDecoder,
    anim_info:webp.WebPAnimInfo,
    out_fmt:color_fmt,
    config:webp_config,
}
webp_decoder :: struct {
    __in : webp_decoder_in,
}


webp_decoder_width :: proc "contextless" (self:^webp_decoder) -> int {
    if self.__in.config != nil {
        switch &t in self.__in.config {
        case webp.WebPDecoderConfig:
            return auto_cast t.input.width
        case webp.WebPAnimDecoderOptions:
            return auto_cast self.__in.anim_info.canvas_width
        }
    }
    return -1
}

webp_decoder_height :: proc "contextless" (self:^webp_decoder) -> int {
    if self.__in.config != nil {
        switch &t in self.__in.config {
        case webp.WebPDecoderConfig:
            return auto_cast t.input.height
        case webp.WebPAnimDecoderOptions:
            return auto_cast self.__in.anim_info.canvas_height
        }
    }
    return -1
}

webp_decoder_size :: proc "contextless" (self:^webp_decoder) -> int {
    if self.__in.config != nil {
        switch &t in self.__in.config {
        case webp.WebPDecoderConfig:
            return int(t.input.height * t.input.width) * (color_fmt_bit(self.__in.out_fmt) >> 3)
        case webp.WebPAnimDecoderOptions:
            return int(self.__in.anim_info.canvas_height * self.__in.anim_info.canvas_width * self.__in.anim_info.frame_count) * (color_fmt_bit(self.__in.out_fmt) >> 3)
        }
    }
    return -1
}

webp_decoder_frame_cnt :: proc "contextless" (self:^webp_decoder) -> int {
    if self.__in.config != nil {
        switch &t in self.__in.config {
        case webp.WebPAnimDecoderOptions:
            return auto_cast self.__in.anim_info.frame_count
        case webp.WebPDecoderConfig:
            return 1
        }
    }
    return -1
}

webp_decoder_deinit :: proc "contextless" (self:^webp_decoder) {
    if self.__in.config != nil {
        switch &t in self.__in.config {
        case webp.WebPDecoderConfig:
            webp.WebPFreeDecBuffer(&(t.output))
            self.__in.config = nil
        case webp.WebPAnimDecoderOptions:
            webp.WebPAnimDecoderDelete(self.__in.anim_dec)
            self.__in.config = nil
        }
    }
}

webp_decoder_load_header :: proc "contextless" (self:^webp_decoder, data:[]u8, out_fmt:color_fmt) -> int {
    webp_decoder_deinit(self)

    errCode := 0
    animOp:^webp.WebPAnimDecoderOptions

    anim_load: {   
        self.__in.config = webp.WebPAnimDecoderOptions{}
        webp.WebPAnimDecoderOptionsInit(&self.__in.config.(webp.WebPAnimDecoderOptions))

        wData := webp.WebPData{
            bytes = &data[0],
            size = len(data),
        }
        animOp = &self.__in.config.(webp.WebPAnimDecoderOptions)
        #partial switch out_fmt {
            case .RGBA : animOp.color_mode = webp.CSP_MODE.RGBA
            case .ARGB : animOp.color_mode = webp.CSP_MODE.ARGB
            case .BGRA : animOp.color_mode = webp.CSP_MODE.BGRA
            case .RGB : animOp.color_mode = webp.CSP_MODE.RGB
            case .BGR : animOp.color_mode = webp.CSP_MODE.BGR
            case : trace.panic_log("unsupports decode fmt : ", out_fmt)
        }

        self.__in.anim_dec = webp.WebPAnimDecoderNew(&wData, &self.__in.config.(webp.WebPAnimDecoderOptions))
        if self.__in.anim_dec == nil {
            errCode = -1
            break anim_load
        }

        webp.WebPAnimDecoderGetInfo(self.__in.anim_dec, &self.__in.anim_info)
    }
    
    if errCode != 0 {
        //try load static image mode
        self.__in.config = webp.WebPDecoderConfig{}
        webp.WebPInitDecoderConfig(&self.__in.config.(webp.WebPDecoderConfig))
        op := &self.__in.config.(webp.WebPDecoderConfig)
        op.options.no_fancy_upsampling = true
        errCode = auto_cast webp.WebPGetFeatures(&data[0], len(data), &op.input)
        if errCode != cast(int)webp.VP8StatusCode.OK {
            self.__in.config = nil
            return errCode
        }

        op.options.scaled_width = op.input.width
        op.options.scaled_height = op.input.height
        op.output.colorspace = animOp.color_mode
    }

    self.__in.out_fmt = out_fmt
    self.__in.input_data = data

    return errCode
}

webp_decoder_decode :: proc "contextless" (self:^webp_decoder, out_data:[]u8) -> int {
    if self.__in.config == nil {
        trace.panic_log("webp_decoder_decode load_header first!")
    }

    bit := color_fmt_bit(self.__in.out_fmt) >> 3

    switch &t in self.__in.config {
    case webp.WebPDecoderConfig:
        t.output.u.RGBA.rgba = &out_data[0]
        t.output.u.RGBA.stride = t.input.width * i32(bit)
        t.output.u.RGBA.size = uint(t.output.u.RGBA.stride * t.input.height)
        if int(t.output.u.RGBA.size) > len(out_data)  {
            trace.panic_log("webp_decoder_decode out_data too small")
        }
        t.output.is_external_memory = 1

        errCode := webp.WebPDecode(&self.__in.input_data[0], len(self.__in.input_data), &t)
        if errCode != .OK do return int(errCode)

    case webp.WebPAnimDecoderOptions:
        idx := 0

        frame_size := int(self.__in.anim_info.canvas_width * self.__in.anim_info.canvas_height) * bit
        if int(self.__in.anim_info.frame_count) * frame_size > len(out_data)  {
            trace.panic_log("webp_decoder_decode out_data too small")
        }

        for 0 < webp.WebPAnimDecoderHasMoreFrames(self.__in.anim_dec) {
            timestamp : i32
            buf : [^]u8

            if 0 == webp.WebPAnimDecoderGetNext(self.__in.anim_dec, &buf, &timestamp) {
                return -1
            }
            intrinsics.mem_copy_non_overlapping(&out_data[idx], buf, frame_size)

            idx += frame_size
        }
    }
    return 0
}