cmake_minimum_required(VERSION 3.22)

message(VAR(ffmpeg) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

set(FFMPEG_ROOT "./ffmpeg")

include_directories(
  PUBLIC 
  "./ffmpeg"
  "./ffmpeg/fftools"
  "./"
  )

include_directories(
  INTERFACE "./ffmpeg"
  )

set_directory_properties(PROPERTIES LINK_FLAGS 
  "-s USE_SDL=2"                                  # use SDL2
  "-s INVOKE_RUN=0"                               # not to run the main() in the beginning
  "-s EXIT_RUNTIME=1"                             # exit runtime after execution
  "-s MODULARIZE=1"                               # use modularized version to be more flexible
  "-s EXPORT_NAME=\"createFFmpegCore\" " # assign export name for browser
  "-s EXPORTED_FUNCTIONS=\"$EXPORTED_FUNCTIONS\" " # export main and proxy_main funcs
  "-s EXTRA_EXPORTED_RUNTIME_METHODS=\"[FS, cwrap, ccall, setValue, writeAsciiToMemory, lengthBytesUTF8, stringToUTF8, UTF8ToString]\" "   # export preamble funcs
  "--post-js ${FFMPEG_ROOT}/wasm/src/post.js"
  "--pre-js ${FFMPEG_ROOT}/wasm/src/pre.js"
)

# WRITE OUR OWN CONFIG.H to control x264
SET(FFMPEG_INCLUDE_HEADER_DIR ${CMAKE_CURRENT_SOURCE_DIR}/ffmpeg)

include(./ffmpeg_config.h.in.cmake) 
configure_file(./ffmpeg_config.h.in ${FFMPEG_INCLUDE_HEADER_DIR}/config.h NO_SOURCE_PERMISSIONS @ONLY)

include(./ffmpeg_config_components.h.in.cmake)
configure_file(./ffmpeg_config_components.h.in ${FFMPEG_INCLUDE_HEADER_DIR}/config_components.h NO_SOURCE_PERMISSIONS @ONLY)

function(deploy_ff_assemblies module_name)
  file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/deploy/ffmpeg/${module_name}/CMakeLists.txt 
    DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/ffmpeg/${module_name})
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/ffmpeg/${module_name})
endfunction()

deploy_ff_assemblies(libavutil)
deploy_ff_assemblies(libavdevice)
deploy_ff_assemblies(libavfilter)

