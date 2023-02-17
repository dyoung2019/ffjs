cmake_minimum_required(VERSION 3.22)

message(VAR(x264) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

# install-lib-static
# $(LIBX264): $(OBJS) $(OBJASM)
	# rm -f $(LIBX264)
	# $(AR)$@ $(OBJS) $(OBJASM)
	# $(if $(RANLIB), $(RANLIB) $@)

# target_compile_options(x264 PRIVATE --disable-cli)
#   if [ "$cli" = "no" ] ; then
#   avs="no" 
#   lavf="no"
#   ffms="no"
#   gpac="no"
#   lsmash="no"
#   mp4="no"
#   swscale="no"
# fi

set(X_DIR "./x264/")

# target_compile_options(x264 PRIVATE --enable-static)
add_library(x264 STATIC
  # SRCS
  ${X_DIR}common/osdep.c
  ${X_DIR}common/base.c
  ${X_DIR}common/cpu.c
  ${X_DIR}common/tables.c
  ${X_DIR}encoder/api.c
)

set(x264_srcx 
  ${X_DIR}common/mc.c
  ${X_DIR}common/predict.c
  ${X_DIR}common/pixel.c
  ${X_DIR}common/macroblock.c
  ${X_DIR}common/frame.c
  ${X_DIR}common/dct.c
  ${X_DIR}common/cabac.c
  ${X_DIR}common/common.c
  ${X_DIR}common/rectangle.c
  ${X_DIR}common/set.c
  ${X_DIR}common/quant.c
  ${X_DIR}common/deblock.c 
  ${X_DIR}common/vlc.c
  ${X_DIR}common/mvpred.c
  ${X_DIR}common/bitstream.c
  ${X_DIR}encoder/analyse.c 
  ${X_DIR}encoder/me.c 
  ${X_DIR}encoder/ratecontrol.c
  ${X_DIR}encoder/set.c 
  ${X_DIR}encoder/macroblock.c 
  ${X_DIR}encoder/cabac.c 
  ${X_DIR}encoder/cavlc.c
  ${X_DIR}encoder/encoder.c 
  ${X_DIR}encoder/lookahead.c
)

add_library(x264_0_8 OBJECT ${x264_srcx})
target_compile_definitions(x264_0_8 PRIVATE HIGH_BIT_DEPTH=0)
target_compile_definitions(x264_0_8 PRIVATE BIT_DEPTH=8)
add_library(x264_1_10 OBJECT ${x264_srcx})
target_compile_definitions(x264_1_10 PRIVATE HIGH_BIT_DEPTH=1)
target_compile_definitions(x264_1_10 PRIVATE BIT_DEPTH=10)
target_link_libraries(x264 x264_0_8 x264_1_10)

# target_compile_options(x264 INTERFACE
#   ""
# )

# i686-openbsd
# platform:       X86
# byte order:     little-endian
# system:         OPENBSD
# cli:            no
# libx264:        internal
# shared:         no
# static:         yes
# bashcompletion: no
# asm:            no
# interlaced:     yes
# avs:            no
# lavf:           no
# ffms:           no
# mp4:            no
# gpl:            yes
# thread:         posix
# opencl:         no
# filters:        crop select_every
# lto:            no
# debug:          no
# gprof:          no
# strip:          no
# PIC:            no
# bit depth:      all
# chroma format:  all


set_target_properties(x264 PROPERTIES LINK_FLAGS 
  "-Wshadow;-O3;-ffast-math;-m32;-Wall;-std=gnu99;-D_GNU_SOURCE;-fomit-frame-pointer;-fno-tree-vectorize;-fvisibility=hidden"
)


target_include_directories(x264 PUBLIC ${X_DIR})
target_include_directories(x264_0_8 PUBLIC ${X_DIR})
target_include_directories(x264_1_10 PUBLIC ${X_DIR})
target_include_directories(x264 INTERFACE ${X_DIR})
target_include_directories(x264_0_8 INTERFACE ${X_DIR})
target_include_directories(x264_1_10 INTERFACE ${X_DIR})


# target_compile_options(x264 PRIVATE --disable-asm)

list(APPEND EXTRA_LIBS x264)

# i686-openbsd

#define ARCH_X86 1
#define SYS_OPENBSD 1
#define STACK_ALIGNMENT 4
#define HAVE_POSIXTHREAD 1
#define HAVE_THREAD 1
#define HAVE_LOG2F 1
#define HAVE_STRTOK_R 1
#define HAVE_CLOCK_GETTIME 1
#define HAVE_MMAP 1
#define HAVE_VECTOREXT 1
#define fseek fseeko
#define ftell ftello
#define HAVE_BITDEPTH8 1
#define HAVE_BITDEPTH10 1
#define HAVE_GPL 1
#define HAVE_INTERLACED 1
#define HAVE_MALLOC_H 0
#define HAVE_ALTIVEC 0
#define HAVE_ALTIVEC_H 0
#define HAVE_MMX 0
#define HAVE_ARMV6 0
#define HAVE_ARMV6T2 0
#define HAVE_NEON 0
#define HAVE_AARCH64 0
#define HAVE_BEOSTHREAD 0
#define HAVE_WIN32THREAD 0
#define HAVE_SWSCALE 0
#define HAVE_LAVF 0
#define HAVE_FFMS 0
#define HAVE_GPAC 0
#define HAVE_AVS 0
#define HAVE_CPU_COUNT 0
#define HAVE_OPENCL 0
#define HAVE_THP 0
#define HAVE_LSMASH 0
#define HAVE_X86_INLINE_ASM 0
#define HAVE_AS_FUNC 0
#define HAVE_INTEL_DISPATCHER 0
#define HAVE_MSA 0
#define HAVE_WINRT 0
#define HAVE_VSX 0
#define HAVE_ARM_INLINE_ASM 0
