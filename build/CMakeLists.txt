cmake_minimum_required(VERSION 3.22)

message(VAR(build) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

include(./zlib.cmake)
include(./ffmpeg.cmake)