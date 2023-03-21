cmake_minimum_required(VERSION 3.22)
message(VAR(liblame) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

# --host=i686-linux                                   # use i686 linux
# --disable-shared                                    # disable shared library
# --disable-frontend                                  # exclude lame executable
# --disable-analyzer-hooks                            # exclude analyzer hooks
# --disable-dependency-tracking                       # speed up one-time build
# --disable-gtktest

SET(LAME_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lame/)
set(LAME_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lame/include/)
set(LAME_LIBMP3LAME_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lame/libmp3lame/)
set(LAME_LIBMPGLIB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/lame/mpglib/)

include(./liblame_config.h.in.cmake)
configure_file(./liblame_config.h.in ${LAME_ROOT_DIR}config.h NO_SOURCE_PERMISSIONS @ONLY)

macro(deploy_lame_module module_name)
  SET(LAME_SRC_DIR ${LAME_ROOT_DIR}${module_name})

  file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/deploy/lame/${module_name}/CMakeLists.txt 
    DESTINATION ${LAME_SRC_DIR})
  add_subdirectory(${LAME_SRC_DIR})
endmacro()

deploy_lame_module(libmp3lame)
deploy_lame_module(mpglib)

add_library(lame STATIC 
  $<TARGET_OBJECTS:lame-libmp3lame>
  $<TARGET_OBJECTS:lame-mpglib>
)