package engine


image_converter_width :: proc {
    webp_decoder_width,
    png_decoder_width,
}

image_converter_height :: proc {
    webp_decoder_height,
    png_decoder_height,
}

image_converter_size :: proc {
    webp_decoder_size,
    png_decoder_size,
}

image_converter_frame_cnt :: proc {
    webp_decoder_frame_cnt,
}

image_converter_deinit :: proc {
    webp_decoder_deinit,
    png_decoder_deinit,
}

image_converter_load :: proc {
    webp_decoder_load,
    png_decoder_load,
}

image_converter_load_file :: proc {
    webp_decoder_load_file,
    png_decoder_load_file,
}