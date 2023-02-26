cmake_minimum_required(VERSION 3.22)

message(VAR(x265-encoder) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

set(x265_esrc 
motion.h
analysis.cpp
analysis.h
search.cpp 
search.h
bitcost.cpp
bitcost.h 
rdcost.h
motion.cpp
slicetype.cpp
slicetype.h
frameencoder.cpp
frameencoder.h
framefilter.cpp
framefilter.h
level.cpp
level.h
nal.cpp 
nal.h
sei.cpp
sei.h
sao.cpp
sao.h
entropy.cpp
entropy.h
dpb.cpp
dpb.h
ratecontrol.cpp
ratecontrol.h
reference.cpp
reference.h
encoder.cpp 
encoder.h
api.cpp
weightPrediction.cpp
svt.h
)

add_library(                x265_encoder_8 OBJECT ${x265_esrc})
target_compile_definitions( x265_encoder_8 PRIVATE LINKED_8BIT=1)
target_compile_definitions( x265_encoder_8 PRIVATE HIGH_BIT_DEPTH=0)
target_compile_definitions( x265_encoder_8 PRIVATE X265_DEPTH=8)
target_compile_definitions( x265_encoder_8 PRIVATE HAVE_STRTOK_R=1)
target_compile_features(    x265_encoder_8 PRIVATE cxx_std_11)
set_property(TARGET         x265_encoder_8 PROPERTY CXX_STANDARD 11)
target_include_directories( x265_encoder_8 PRIVATE 
  ${X265_COMMON_DIR}
  ${X265_INCLUDE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
)

add_library(                x265_encoder_10 OBJECT ${x265_esrc})
target_compile_definitions( x265_encoder_10 PRIVATE LINKED_10BIT=1)
target_compile_definitions( x265_encoder_10 PRIVATE HIGH_BIT_DEPTH=1)
target_compile_definitions( x265_encoder_10 PRIVATE X265_DEPTH=10)
target_compile_definitions( x265_encoder_10 PRIVATE HAVE_STRTOK_R=1)
target_compile_features(    x265_encoder_10 PRIVATE cxx_std_11)
set_property(TARGET         x265_encoder_10 PROPERTY CXX_STANDARD 11)
target_include_directories( x265_encoder_10 PRIVATE 
  ${X265_COMMON_DIR}
  ${X265_INCLUDE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
)

add_library(                x265_encoder_12 OBJECT ${x265_esrc})
target_compile_definitions( x265_encoder_12 PRIVATE LINKED_12BIT=1)
target_compile_definitions( x265_encoder_12 PRIVATE HIGH_BIT_DEPTH=1)
target_compile_definitions( x265_encoder_12 PRIVATE X265_DEPTH=12)
target_compile_definitions( x265_encoder_12 PRIVATE HAVE_STRTOK_R=1)
target_compile_features(    x265_encoder_12 PRIVATE cxx_std_11)
set_property(TARGET         x265_encoder_12 PROPERTY CXX_STANDARD 11)
target_include_directories( x265_encoder_12 PRIVATE 
  ${X265_COMMON_DIR}
  ${X265_INCLUDE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}
)

