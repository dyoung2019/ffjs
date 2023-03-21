cmake_minimum_required(VERSION 3.22)
message(VAR(lame-libmp3lame) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

add_library(lame-libmp3lame OBJECT
  VbrTag.c
  bitstream.c
  encoder.c
  fft.c
  gain_analysis.c
  id3tag.c
  lame.c
  newmdct.c
  presets.c
  psymodel.c
  quantize.c
  quantize_pvt.c
  reservoir.c
  set_get.c
  tables.c
  takehiro.c
  util.c
  vbrquantize.c
  version.c
  mpglib_interface.c
)

target_include_directories(
  lame-libmp3lame PUBLIC 
  ${LAME_ROOT_DIR}
  ${LAME_INCLUDE_DIR}
  ${LAME_LIBMPGLIB_DIR}
)

target_compile_definitions(lame-libmp3lame PUBLIC HAVE_MEMCPY)
target_compile_definitions(lame-libmp3lame PUBLIC HAVE_CONFIG_H)