cmake_minimum_required(VERSION 3.25)
project(ff VERSION 1.0.0) 

SET(MAXIMUM_MEMORY "4GB")

option(USE_PROBE_X "Using probe-x" ON)

option(USE_FFMPEG "Using ffmpeg" ON)

if(USE_FFMPEG)
  set(FFMPEG_BUILD_DIR "./build")
  add_subdirectory(${FFMPEG_BUILD_DIR})
  list(APPEND EXTRA_LIBS ffmpeg)
  list(APPEND EXTRA_INCLUDES "${FFMPEG_BUILD_DIR}/ffmpeg")
endif()

if(USE_PROBE_X)
  set(PROBE_X_SRC_DIR "./src/probe-x")
  add_subdirectory(${PROBE_X_SRC_DIR})
  list(APPEND EXTRA_LIBS probe-x)
  list(APPEND EXTRA_INCLUDES ${PROBE_X_SRC_DIR})
endif()

target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

target_include_directories(Tutorial PUBLIC
  "${PROJECT_BINARY_DIR}"
  ${EXTRA_INCLUDES}
)