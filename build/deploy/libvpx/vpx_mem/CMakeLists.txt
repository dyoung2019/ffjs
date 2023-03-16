cmake_minimum_required(VERSION 3.22)
message(VAR(vpx_mem) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

add_library(vpx_mem OBJECT 
  vpx_mem.c
)

target_include_directories(vpx_mem PUBLIC ${LIBVPX_ROOT_DIR})