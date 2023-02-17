cmake_minimum_required(VERSION 3.22)

message(VAR(x264) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

set(X_DIR "./x264/")
set(X_LINK_FLAGS "-Wshadow;-O3;-ffast-math;-m32;-Wall;-std=gnu99;-D_GNU_SOURCE;-fomit-frame-pointer;-fno-tree-vectorize;-fvisibility=hidden")

add_library(x264 STATIC
  ${X_DIR}common/osdep.c
  ${X_DIR}common/base.c
  ${X_DIR}common/cpu.c
  ${X_DIR}common/tables.c
  ${X_DIR}encoder/api.c
)

set(x264_srcx 
  ${X_DIR}common/mc.c
  ${X_DIR}common/predict.c
  ${X_DIR}common/pixel.c
  ${X_DIR}common/macroblock.c
  ${X_DIR}common/frame.c
  ${X_DIR}common/dct.c
  ${X_DIR}common/cabac.c
  ${X_DIR}common/common.c
  ${X_DIR}common/rectangle.c
  ${X_DIR}common/set.c
  ${X_DIR}common/quant.c
  ${X_DIR}common/deblock.c 
  ${X_DIR}common/vlc.c
  ${X_DIR}common/mvpred.c
  ${X_DIR}common/bitstream.c
  ${X_DIR}encoder/analyse.c 
  ${X_DIR}encoder/me.c 
  ${X_DIR}encoder/ratecontrol.c
  ${X_DIR}encoder/set.c 
  ${X_DIR}encoder/macroblock.c 
  ${X_DIR}encoder/cabac.c 
  ${X_DIR}encoder/cavlc.c
  ${X_DIR}encoder/encoder.c 
  ${X_DIR}encoder/lookahead.c
)

add_library(x264_0_8 OBJECT ${x264_srcx})
target_compile_definitions(x264_0_8 PRIVATE HIGH_BIT_DEPTH=0)
target_compile_definitions(x264_0_8 PRIVATE BIT_DEPTH=8)
add_library(x264_1_10 OBJECT ${x264_srcx})
target_compile_definitions(x264_1_10 PRIVATE HIGH_BIT_DEPTH=1)
target_compile_definitions(x264_1_10 PRIVATE BIT_DEPTH=10)
target_link_libraries(x264 x264_0_8 x264_1_10)

target_compile_options(x264 INTERFACE ${X_LINK_FLAGS})

target_include_directories(x264 PUBLIC ${X_DIR})
target_include_directories(x264_0_8 PUBLIC ${X_DIR})
target_include_directories(x264_1_10 PUBLIC ${X_DIR})
target_include_directories(x264 INTERFACE ${X_DIR})
target_include_directories(x264_0_8 INTERFACE ${X_DIR})
target_include_directories(x264_1_10 INTERFACE ${X_DIR})

list(APPEND EXTRA_LIBS x264)
