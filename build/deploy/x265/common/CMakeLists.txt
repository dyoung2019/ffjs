cmake_minimum_required(VERSION 3.22)

message(VAR(x265-common) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

set(x265_csrc
primitives.cpp
primitives.h
pixel.cpp
dct.cpp 
lowpassdct.cpp 
ipfilter.cpp 
intrapred.cpp 
loopfilter.cpp
constants.cpp
constants.h
cpu.cpp
cpu.h
version.cpp
threading.cpp
threading.h
threadpool.cpp
threadpool.h
wavefront.h
wavefront.cpp
md5.cpp
md5.h
bitstream.h
bitstream.cpp
yuv.cpp
yuv.h
shortyuv.cpp
shortyuv.h
picyuv.cpp
picyuv.h
common.cpp
common.h
param.cpp
param.h
frame.cpp
frame.h
framedata.cpp
framedata.h
cudata.cpp
cudata.h
slice.cpp
slice.h
lowres.cpp
lowres.h
mv.h
piclist.cpp
piclist.h
predict.cpp
predict.h
scalinglist.cpp
scalinglist.h
quant.cpp
quant.h
contexts.h
deblock.cpp
deblock.h
scaler.cpp
scaler.h
ringmem.cpp
ringmem.h
temporalfilter.cpp
temporalfilter.h
)

add_library(                x265_common_8 OBJECT ${x265_csrc})
target_compile_definitions( x265_common_8 PRIVATE LINKED_8BIT=1)
target_compile_definitions( x265_common_8 PRIVATE HIGH_BIT_DEPTH=0)
target_compile_definitions( x265_common_8 PRIVATE X265_DEPTH=8)
target_compile_definitions( x265_common_8 PRIVATE HAVE_STRTOK_R=1)
target_compile_features(    x265_common_8 PRIVATE cxx_std_11)
set_property(TARGET         x265_common_8 PROPERTY CXX_STANDARD 11)
target_include_directories( x265_common_8 PRIVATE 
  ${X265_INCLUDE_DIR}
  ${X265_ENCODE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
)

add_library(                x265_common_10 OBJECT ${x265_csrc})
target_compile_definitions( x265_common_10 PRIVATE LINKED_10BIT=1)
target_compile_definitions( x265_common_10 PRIVATE HIGH_BIT_DEPTH=1)
target_compile_definitions( x265_common_10 PRIVATE X265_DEPTH=10)
target_compile_definitions( x265_common_10 PRIVATE HAVE_STRTOK_R=1)
target_compile_features(    x265_common_10 PRIVATE cxx_std_11)
set_property(TARGET         x265_common_10 PROPERTY CXX_STANDARD 11)
target_include_directories( x265_common_10 PRIVATE 
  ${X265_INCLUDE_DIR}
  ${X265_ENCODE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
)

add_library(                x265_common_12 OBJECT ${x265_csrc})
target_compile_definitions( x265_common_12 PRIVATE LINKED_12BIT=1)
target_compile_definitions( x265_common_12 PRIVATE HIGH_BIT_DEPTH=1)
target_compile_definitions( x265_common_12 PRIVATE X265_DEPTH=12)
target_compile_definitions( x265_common_12 PRIVATE HAVE_STRTOK_R=1)
target_compile_features(    x265_common_12 PRIVATE cxx_std_11)
set_property(TARGET         x265_common_12 PROPERTY CXX_STANDARD 11)
target_include_directories( x265_common_12 PRIVATE 
  ${X265_INCLUDE_DIR}
  ${X265_ENCODE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
)