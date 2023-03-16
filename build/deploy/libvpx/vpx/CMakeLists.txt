cmake_minimum_required(VERSION 3.22)
message(VAR(vpx_codec) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

SET(VPX_SRC_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/src/)

add_library(vpx_codec OBJECT
  ${VPX_SRC_ROOT}vpx_codec.c
  ${VPX_SRC_ROOT}vpx_decoder.c
  ${VPX_SRC_ROOT}vpx_encoder.c
  ${VPX_SRC_ROOT}vpx_image.c
)

target_include_directories(vpx_codec PUBLIC ${LIBVPX_ROOT_DIR})
