SET(VPX_SRC_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/src/)

add_library(vpx_codec OBJECT 
  ${VPX_SRC_ROOT}vpx_codec.c
  ${VPX_SRC_ROOT}vpx_decoder.c
  ${VPX_SRC_ROOT}vpx_encoder.c
  ${VPX_SRC_ROOT}vpx_image.c
)

target_include_directories(vpx_codec PUBLIC ${LIBVPX_ROOT_DIR})

LIST(APPEND VPX_MODULES vpx_codec)
