cmake_minimum_required(VERSION 3.22)

message(VAR(probe-x) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

add_library(probe-x 
  ./src/free_decoder_context.c
  ./src/init_decoder_context.c
  ./src/loop_thru_streams.cpp
  ./src/open_video_file.cpp
  ./src/print_a_stream.c
  ./src/print_audio_parameters.c
  ./src/print_disposition_info.c
  ./src/print_stream_parameters.c
  ./src/print_sub_parameters.c
  ./src/print_tags_dictionary.c
  ./src/print_utils.c
  ./src/print_video_format.c
  ./src/print_video_parameters.c
  ./src/probe_video_file.cpp
  ./src/ResponseWriter.cpp
  ./src/StringCache.c
  ./src/utils.c
)

target_compile_options(probe-x INTERFACE
  "$<${gcc_like_cxx}:-Wno-deprecated-declarations;-Wno-pointer-sign;-Wno-implicit-int-float-conversion;-Wno-switch;-Wno-parentheses;-Wunused-arguments>"
  "$<${msvc_cxx}:-W3>"
)

target_include_directories(probe-x
  PUBLIC "../../build/ffmpeg"
  )

target_include_directories(probe-x
  INTERFACE "./src"
  )