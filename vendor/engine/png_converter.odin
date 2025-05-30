package engine

import "core:mem"
import "core:debug/trace"
import "base:intrinsics"
import "base:runtime"
import "core:image/png"
import "core:image"
import "core:bytes"


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

png_decoder_load :: proc (self:^png_decoder, data:[]byte, out_fmt:color_fmt, allocator := context.allocator) -> ([]byte, image.Error) {
    png_decoder_deinit(self)

    err : image.Error = nil
    self.__in.img, err = png.load_from_bytes(data, allocator = allocator)
    self.__in.allocator = allocator

    if err != nil {
        return nil, err
    }
    
    out_data := bytes.buffer_to_bytes(&self.__in.img.pixels)
  
    return out_data, err
}