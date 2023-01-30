cmake_minimum_required(VERSION 3.22)
project(ff VERSION 1.0.0)
set(VERSION 3.22)

SET(MAXIMUM_MEMORY "4GB")

option(USE_PROBE_X "Using probe-x" ON)

option(USE_FFMPEG "Using ffmpeg" OFF)

if(USE_FFMPEG)
  set(FFMPEG_BUILD_DIR "./build")
  add_subdirectory(${FFMPEG_BUILD_DIR})
  list(APPEND EXTRA_LIBS libavcodec libavdevice)
endif()

if(USE_PROBE_X)
  set(PROBE_X_SRC_DIR "./src/probe-x")
  add_subdirectory(${PROBE_X_SRC_DIR})
  list(APPEND EXTRA_LIBS probe-x)
endif()

add_executable(ff
  ./src/ff_main.c
)

target_link_libraries(ff ${EXTRA_LIBS})
