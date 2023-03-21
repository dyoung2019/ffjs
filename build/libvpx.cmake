cmake_minimum_required(VERSION 3.22)
message(VAR(libvpx) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

SET(LIBVPX_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libvpx/)

include(./libvpx_config.h.in.cmake)
configure_file(./libvpx_version.h.in ${LIBVPX_ROOT_DIR}vpx_version.h NO_SOURCE_PERMISSIONS @ONLY)
configure_file(./libvpx_config.h.in ${LIBVPX_ROOT_DIR}vpx_config.h NO_SOURCE_PERMISSIONS @ONLY)

macro(deploy_vpx_module module_name)
  SET(VPX_SRC_DIR ${LIBVPX_ROOT_DIR}${module_name})

  file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/deploy/libvpx/${module_name}/CMakeLists.txt 
    DESTINATION ${VPX_SRC_DIR})
  add_subdirectory(${VPX_SRC_DIR})
endmacro()

deploy_vpx_module(vpx)
deploy_vpx_module(vpx_mem)
deploy_vpx_module(vpx_dsp)
deploy_vpx_module(vpx_scale)
deploy_vpx_module(vpx_ports)
deploy_vpx_module(vpx_util)
deploy_vpx_module(vp8)
deploy_vpx_module(vp9)

add_library(libvpx STATIC 
  $<TARGET_OBJECTS:vpx_codec>
  $<TARGET_OBJECTS:vpx_mem>
  $<TARGET_OBJECTS:vpx_dsp>
  $<TARGET_OBJECTS:vpx_util>
  $<TARGET_OBJECTS:vpx_scale>
)

if ($<TARGET_OBJECTS:vpx_ports>)
  message(vpx_ports is compiled)
  target_link_libraries(libvpx PUBLIC vpx_ports $<TARGET_OBJECTS:vpx_ports>)
endif()

if (CONFIG_VP8)
  target_link_libraries(libvpx PRIVATE vp8_common)

  if (CONFIG_VP8_ENCODER)
    target_link_libraries(libvpx PRIVATE vp8_encoder)
  endif()

  if (CONFIG_VP8_DECODER)
    target_link_libraries(libvpx PRIVATE vp8_decoder)
  endif()
endif()

if (CONFIG_VP9)
  target_link_libraries(libvpx PRIVATE vp9_common)

  if (CONFIG_VP9_ENCODER)
    target_link_libraries(libvpx PRIVATE vp9_encoder)
  endif()

  if (CONFIG_VP9_DECODER)
    target_link_libraries(libvpx PRIVATE vp9_decoder)
  endif()
endif()

