add_library(vpx_mem OBJECT 
  vpx_mem.c
)

target_include_directories(vpx_mem PUBLIC ${LIBVPX_ROOT_DIR})

LIST(APPEND VPX_MODULES vpx_mem)