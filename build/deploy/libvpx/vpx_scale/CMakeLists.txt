cmake_minimum_required(VERSION 3.22)
message(VAR(vpx_scale) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

add_library(vpx_scale OBJECT 
  generic/yv12config.c
  generic/yv12config.c
  generic/yv12extend.c
  vpx_scale_rtcd.c
)

target_include_directories(vpx_scale 
  PUBLIC ${LIBVPX_ROOT_DIR}
)

set(extra_srcs)

if (CONFIG_SPATIAL_RESAMPLING)
  list(APPEND extra_srcs 
    generic/vpx_scale.c
    generic/gen_scalers.c  
  )
endif()

if (HAVE_DSPR2)
  list(APPEND extra_srcs 
    mips/dspr2/yv12extend_dspr2.c
  )
endif()

list(REMOVE_DUPLICATES extra_srcs)

IF( extra_srcs )
  add_library(vpx_scale_aux1 OBJECT ${extra_srcs})
  
  target_include_directories(vpx_scale_aux1 
    PUBLIC ${LIBVPX_ROOT_DIR})

  target_link_libraries(vpx_scale vpx_scale_aux1)
ENDIF()