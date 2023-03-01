add_library(vpx_util OBJECT 
  vpx_thread.c
  vpx_write_yuv_frame.c
)

target_include_directories(
  vpx_util 
  PUBLIC ${LIBVPX_ROOT_DIR})

IF( CONFIG_BITSTREAM_DEBUG OR CONFIG_MISMATCH_DEBUG)
  add_library(vpx_util_aux0
    OBJECT 
    $vpx_debug_util.c)
  
  target_include_directories(vpx_util_aux0 
    PUBLIC ${LIBVPX_ROOT_DIR})

  target_link_libraries(vpx_util vpx_util_aux0)
ENDIF()

LIST(APPEND VPX_MODULES vpx_util)