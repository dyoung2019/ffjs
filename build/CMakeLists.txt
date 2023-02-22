cmake_minimum_required(VERSION 3.22)

message(VAR(build) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

include(./zlib.cmake)
include(./x264.cmake)
include(./x265.cmake)
include(./ffmpeg.cmake)
# include(./ffmpeg.cmake)