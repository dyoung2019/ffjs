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

# file(GLOB LIBAVDEVICE_SRC
#   "${FFMPEG_ROOT}/libavdevice/*.c"
#   "${FFMPEG_ROOT}/libavdevice/*.cpp"
# )

# add_Library(libavdevice ${LIBAVDEVICE_SRC})


macro(setup_library)
  # reads the arguments passed down by parent fn
  foreach(arg IN LISTS ARGN)
    # message(${arg})
    # message(${arg}_SRC)
    file(GLOB ${arg}_SRC
      "${FFMPEG_ROOT}/${arg}/*.c"
      "${FFMPEG_ROOT}/${arg}/*.cpp"
    )
    add_Library(${arg} ${${arg}_SRC})
  endforeach()
endmacro()

function(setup_ff_components)
  setup_library()
endfunction()

# setup_ff_components(
#   libavdevice 
#   libavfilter 
#   libavformat 
#   libavcodec 
#   libpostproc 
#   libswresample 
#   libswscale
# )

# WRITE OUR OWN CONFIG.H to control x264
include(./ffmpeg_config.h.in.cmake) 
configure_file(./ffmpeg_config.h.in "build/ffmpeg/config.h" NO_SOURCE_PERMISSIONS @ONLY)

include(./ffmpeg_config_components.h.in.cmake)
configure_file(./ffmpeg_config_components.h.in "build/ffmpeg/config_components.h" NO_SOURCE_PERMISSIONS @ONLY)

SET(FFMPEG_CONFIG_HEADER_DIR "${CMAKE_CURRENT_BINARY_DIR}/build/ffmpeg")

include(./ffmpeg.libavutil.cmake)
# include(./ffmpeg.libavdevice.cmake)
# include(./ffmpeg.libavfilter.cmake)
