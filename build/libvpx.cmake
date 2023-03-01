cmake_minimum_required(VERSION 3.22)

message(VAR(libvpx) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

# --prefix=$BUILD_DIR                                # install library in a build directory for FFmpeg to include
# --target=generic-gnu                               # target with miminal features
# --disable-install-bins                             # not to install bins
# --disable-examples                                 # not to build examples
# --disable-tools                                    # not to build tools
# --disable-docs                                     # not to build docs
# --disable-unit-tests                               # not to do unit tests
# --disable-dependency-tracking                      # speed up one-time build
# --extra-cflags="$CFLAGS"                           # flags to use pthread and code optimization
# --extra-cxxflags="$CXXFLAGS"    

SET(LIBVPX_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libvpx/)

include(./libvpx_config.h.in.cmake)
configure_file(./libvpx_version.h.in ${LIBVPX_ROOT_DIR}vpx_version.h NO_SOURCE_PERMISSIONS @ONLY)
configure_file(./libvpx_config.h.in ${LIBVPX_ROOT_DIR}vpx_config.h NO_SOURCE_PERMISSIONS @ONLY)

function(deploy_vpx_module module_name)
  SET(VPX_SRC_DIR ${LIBVPX_ROOT_DIR}${module_name})

  file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/deploy/libvpx/${module_name}/CMakeLists.txt 
    DESTINATION ${VPX_SRC_DIR})
  add_subdirectory(${VPX_SRC_DIR})
endfunction()

SET(VPX_MODULES)

deploy_vpx_module(vpx)
# deploy_vpx_module(vpx/src)

deploy_vpx_module(vpx_mem)
deploy_vpx_module(vpx_scale)
deploy_vpx_module(vpx_ports)
deploy_vpx_module(vpx_dsp)
deploy_vpx_module(vpx_util)
deploy_vpx_module(vp8)

# if (CONFIG_VP9)
#   deploy_vpx_module(vp9_common)
# endif

# if (CONFIG_VP9_ENCODER) 
#   deploy_vpx_module(vp9cx)
# endif

# if (CONFIG_VP9_DECODER) 
#   deploy_vpx_module(vp9dx)
# endif

#filter out assembly code
# LIBVPX_OBJS=$(call objs, $(filter-out $(ASM_INCLUDES), $(CODEC_SRCS)))
# OBJS-yes += $(LIBVPX_OBJS)
# LIBS-$(if yes,$(CONFIG_STATIC)) += $(BUILD_PFX)libvpx.a $(BUILD_PFX)libvpx_g.a
# $(BUILD_PFX)libvpx_g.a: $(LIBVPX_OBJS)

# target_link_libraries( ${VPX_MODULES})