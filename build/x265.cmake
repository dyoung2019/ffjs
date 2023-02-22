cmake_minimum_required(VERSION 3.22)

message(VAR(x265) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

SET(ENABLE_SHARED OFF)
SET(ENABLE_CLI OFF)
add_subdirectory("./x265/source")

list(APPEND EXTRA_LIBS x265_static)