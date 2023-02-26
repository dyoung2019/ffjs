cmake_minimum_required(VERSION 3.22)

message(VAR(libavutil) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

set(COMPAT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../compat/)

add_library(libavutil STATIC
	adler32.c
	aes.c
	aes_ctr.c
	audio_fifo.c
	avstring.c
	avsscanf.c
	base64.c
	blowfish.c
	bprint.c
	buffer.c
	cast5.c
	camellia.c
	channel_layout.c
	color_utils.c
	cpu.c
	crc.c
	csp.c
	des.c
	detection_bbox.c
	dict.c
	display.c
	dovi_meta.c
	downmix_info.c
	encryption_info.c
	error.c
	eval.c
	fifo.c
	file.c
	file_open.c
	float_dsp.c
	fixed_dsp.c
	frame.c
	hash.c
	hdr_dynamic_metadata.c
	hdr_dynamic_vivid_metadata.c
	hmac.c
	hwcontext.c
	imgutils.c
	integer.c
	intmath.c
	lfg.c
	lls.c
	log.c
	log2_tab.c
	lzo.c
	mathematics.c
	mastering_display_metadata.c
	md5.c
	mem.c
	murmur3.c
	opt.c
	parseutils.c
	pixdesc.c
	pixelutils.c
	random_seed.c
	rational.c
	reverse.c
	rc4.c
	ripemd.c
	samplefmt.c
	sha.c
	sha512.c
	slicethread.c
	spherical.c
	stereo3d.c
	threadmessage.c
	time.c
	timecode.c
	tree.c
	twofish.c
	utils.c
	xga_font_data.c
	xtea.c
	tea.c
	tx.c
	tx_float.c
	tx_double.c
	tx_int32.c
	uuid.c
	version.c
	video_enc_params.c
	film_grain_params.c

  ${COMPAT_DIR}getopt.c
	${COMPAT_DIR}strtod.c
)

set_property(TARGET libavutil PROPERTY C_STANDARD 11)

# message(VAR(libavutil-dir).FFMPEG_DIR : ${FFMPEG_INCLUDE_HEADER_DIR})

target_compile_options(libavutil 
  INTERFACE "-Wno-implicit-function-declaration;-Wno-implicit-const-int-float-conversion;"
  PRIVATE "-Wno-pointer-sign"
)

target_compile_options(libavutil PRIVATE -DHAVE_AV_CONFIG_H=1)

target_include_directories(libavutil 
	PUBLIC ${FFMPEG_INCLUDE_HEADER_DIR}
)
target_link_directories(libavutil 
  PUBLIC ${FFMPEG_INCLUDE_HEADER_DIR}
)

# add_library(libavutil_aux0 OBJECT buffer.c)
# target_compile_options(libavutil_aux0 PRIVATE -DHAVE_AV_CONFIG_H=1)
# target_link_libraries(libavutil libavutil_aux0)

set (device_srcs)

if ( CONFIG_CUDA )
	list(APPEND device_srcs
		hwcontext_cuda.c
	)
endif()

if ( CONFIG_D3D11VA )
	list(APPEND device_srcs
		hwcontext_d3d11va.c
	)
endif()

if ( CONFIG_DXVA2 )
	list(APPEND device_srcs
		hwcontext_dxva2.c
	)
endif()

if ( CONFIG_LIBDRM )
	list(APPEND device_srcs
		hwcontext_drm.c
	)
endif()

if ( CONFIG_MACOS_KPERF )
	list(APPEND device_srcs
		macos_kperf.c
	)
endif()

if ( CONFIG_MEDIACODEC )
	list(APPEND device_srcs
		hwcontext_mediacodec.c
	)
endif()

if ( CONFIG_OPENCL )
	list(APPEND device_srcs
		hwcontext_opencl.c
	)
endif()

if ( CONFIG_QSV )
	list(APPEND device_srcs
		hwcontext_qsv.c
	)
endif()

if ( CONFIG_VAAPI )
	list(APPEND device_srcs
		hwcontext_vaapi.c
	)
endif()

if ( CONFIG_VIDEOTOOLBOX )
	list(APPEND device_srcs
		hwcontext_videotoolbox.c
	)
endif()

if ( CONFIG_VDPAU )
	list(APPEND device_srcs
		hwcontext_vdpau.c
	)
endif()

if ( CONFIG_VULKAN )
	list(APPEND device_srcs
		hwcontext_vulkan.c
	)
else ( CONFIG_VULKAN )
	list(APPEND device_srcs
		hwcontext_stub.c
	)
endif()

list(REMOVE_DUPLICATES device_srcs)

IF( device_srcs )
  add_library(libavutil_aux1 OBJECT ${device_srcs})
  
  target_include_directories(libavutil_aux1 
    PUBLIC ${FFMPEG_INCLUDE_HEADER_DIR}
  )
  target_link_directories(libavutil_aux1 
    PUBLIC ${FFMPEG_INCLUDE_HEADER_DIR}
  )
  target_link_libraries(libavutil libavutil_aux1)
ENDIF()

list(APPEND EXTRA_LIBS libavutil)