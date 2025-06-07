package engine

import "core:mem"
import "core:debug/trace"
import "base:intrinsics"
import "base:runtime"
import "core:image/png"
import "core:image"
import "core:bytes"
import "core:os/os2"


@private png_decoder_in :: struct {
    img : ^image.Image,
    allocator:runtime.Allocator,
}
png_decoder :: struct {
    __in : png_decoder_in,
}


png_decoder_width :: proc "contextless" (self:^png_decoder) -> int {
    if self.__in.img != nil {
        return self.__in.img.width
    }
    return -1
}

png_decoder_height :: proc "contextless" (self:^png_decoder) -> int {
    if self.__in.img != nil {
        return self.__in.img.height
    }
    return -1
}

png_decoder_size :: proc "contextless" (self:^png_decoder) -> int {
    if self.__in.img != nil {
        return (self.__in.img.depth >> 3) * self.__in.img.width * self.__in.img.height
    }
    return -1
}

png_decoder_deinit :: proc (self:^png_decoder) {
    if self.__in.img != nil {
        image.destroy(self.__in.img, self.__in.allocator)
        self.__in.img = nil
    }
}

png_decoder_load :: proc (self:^png_decoder, data:[]byte, out_fmt:color_fmt, allocator := context.allocator) -> ([]byte, Png_Error) {
    png_decoder_deinit(self)

    err : image.Error = nil
    #partial switch out_fmt {
        case .RGBA, .RGBA16: self.__in.img, err = png.load_from_bytes(data, png.Options{.alpha_add_if_missing}, allocator = allocator)
        case .RGB, .RGB16: self.__in.img, err = png.load_from_bytes(data, png.Options{.alpha_drop_if_present}, allocator = allocator)
        case : trace.panic_log("unsupport option")
    }
    
    self.__in.allocator = allocator

    if err != nil {
        return nil, err
    }
    
    out_data := bytes.buffer_to_bytes(&self.__in.img.pixels)
  
    return out_data, err
}

Png_Error :: union #shared_nil {
    image.Error,
    os2.Error,
}

png_decoder_load_file :: proc (self:^png_decoder, file_path:string, out_fmt:color_fmt, allocator := context.allocator) -> ([]byte, Png_Error) {
    imgFileData:[]byte
    when is_android {
        imgFileReadErr : Android_AssetFileError
        imgFileData, imgFileReadErr = Android_AssetReadFile(file_path, context.temp_allocator)
        if imgFileReadErr != .None {
            trace.panic_log(imgFileReadErr)
        }
    } else {
        imgFileReadErr:os2.Error
        imgFileData, imgFileReadErr = os2.read_entire_file_from_path(file_path, context.temp_allocator)
        if imgFileReadErr != nil {
            return nil, imgFileReadErr
        }
    }
    defer delete(imgFileData, context.temp_allocator)

    return png_decoder_load(self, imgFileData, out_fmt, allocator)
}