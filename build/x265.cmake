cmake_minimum_required(VERSION 3.22)

message(VAR(x265) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

set(X265_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/x265/source/)
set(X265_ENCODE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/x265/source/encoder/)
set(X265_COMMON_DIR ${CMAKE_CURRENT_SOURCE_DIR}/x265/source/common/)

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/deploy/x265/common/CMakeLists.txt DESTINATION ${X265_COMMON_DIR})
add_subdirectory(${X265_COMMON_DIR})

file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/deploy/x265/encoder/CMakeLists.txt DESTINATION ${X265_ENCODE_DIR})
add_subdirectory(${X265_ENCODE_DIR})

add_library(x265 STATIC 
  $<TARGET_OBJECTS:x265_common_8>
  $<TARGET_OBJECTS:x265_common_10>
  $<TARGET_OBJECTS:x265_common_12>
  $<TARGET_OBJECTS:x265_encoder_8>
  $<TARGET_OBJECTS:x265_encoder_10>
  $<TARGET_OBJECTS:x265_encoder_12>
)
