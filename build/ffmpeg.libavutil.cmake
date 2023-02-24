cmake_minimum_required(VERSION 3.22)

message(VAR(libavutil) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})
# copy makefile in libdevice
# generate a config.h
# generate a config_components h

# store component flags in file
# build source list based on flags

set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

SET(AV_DIR ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg/libavutil/)
SET(FFMPEG_DIR ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg/)
SET(COMPAT_DIR ${CMAKE_CURRENT_BINARY_DIR}/ffmpeg/compat/)

add_library(libavutil STATIC
	${AV_DIR}adler32.c
	${AV_DIR}aes.c
	${AV_DIR}aes_ctr.c
	${AV_DIR}ambient_viewing_environment.c
	${AV_DIR}audio_fifo.c
	${AV_DIR}avstring.c
	${AV_DIR}avsscanf.c
	${AV_DIR}base64.c
	${AV_DIR}blowfish.c
	# ${AV_DIR}bprint.c
	${AV_DIR}buffer.c
	${AV_DIR}cast5.c
	${AV_DIR}camellia.c
	# ${AV_DIR}channel_layout.c
	${AV_DIR}cpu.c
	${AV_DIR}crc.c
	${AV_DIR}csp.c
	${AV_DIR}des.c
	${AV_DIR}detection_bbox.c
	${AV_DIR}dict.c
	${AV_DIR}display.c
	${AV_DIR}dovi_meta.c
	${AV_DIR}downmix_info.c
	${AV_DIR}encryption_info.c
	${AV_DIR}error.c
	${AV_DIR}eval.c
	${AV_DIR}fifo.c
	${AV_DIR}file.c
	${AV_DIR}file_open.c
	${AV_DIR}float_dsp.c
	${AV_DIR}fixed_dsp.c
	${AV_DIR}frame.c
	${AV_DIR}hash.c
	${AV_DIR}hdr_dynamic_metadata.c
	${AV_DIR}hdr_dynamic_vivid_metadata.c
	${AV_DIR}hmac.c
	${AV_DIR}hwcontext.c
	${AV_DIR}imgutils.c
	${AV_DIR}integer.c
	${AV_DIR}intmath.c
	${AV_DIR}lfg.c
	${AV_DIR}lls.c
	${AV_DIR}log.c
	${AV_DIR}log2_tab.c
	${AV_DIR}lzo.c
	${AV_DIR}mathematics.c
	${AV_DIR}mastering_display_metadata.c
	${AV_DIR}md5.c
	${AV_DIR}mem.c
	${AV_DIR}murmur3.c
	${AV_DIR}opt.c
	${AV_DIR}parseutils.c
	${AV_DIR}pixdesc.c
	${AV_DIR}pixelutils.c
	${AV_DIR}random_seed.c
	${AV_DIR}rational.c
	${AV_DIR}reverse.c
	${AV_DIR}rc4.c
	${AV_DIR}ripemd.c
	${AV_DIR}samplefmt.c
	${AV_DIR}sha.c
	${AV_DIR}sha512.c
	${AV_DIR}slicethread.c
	${AV_DIR}spherical.c
	${AV_DIR}stereo3d.c
	${AV_DIR}threadmessage.c
	${AV_DIR}time.c
	${AV_DIR}timecode.c
	${AV_DIR}tree.c
	${AV_DIR}twofish.c
	${AV_DIR}utils.c
	${AV_DIR}xga_font_data.c
	${AV_DIR}xtea.c
	${AV_DIR}tea.c
	${AV_DIR}tx.c
	${AV_DIR}tx_float.c
	${AV_DIR}tx_double.c
	${AV_DIR}tx_int32.c
	${AV_DIR}uuid.c
	${AV_DIR}version.c
	${AV_DIR}video_enc_params.c
	${AV_DIR}film_grain_params.c

	${COMPAT_DIR}getopt.c
	${COMPAT_DIR}strtod.c
)


# ${AV_DIR}bprint.c
add_library(libavutil_bprint OBJECT ${AV_DIR}bprint.c)
target_include_directories(libavutil_bprint 
	PRIVATE ${FFMPEG_CONFIG_HEADER_DIR} 
	PRIVATE ${FFMPEG_DIR}
)
target_compile_options(libavutil_bprint INTERFACE "-Wno-implicit-function-declaration")
target_link_libraries(libavutil libavutil_bprint)

add_library(libavutil_channel_layout OBJECT ${AV_DIR}channel_layout.c)
target_include_directories(libavutil_channel_layout 
	PRIVATE ${FFMPEG_CONFIG_HEADER_DIR} 
	PRIVATE ${FFMPEG_DIR}
	PRIVATE ${AV_DIR}
)
target_link_libraries(libavutil libavutil_channel_layout)

add_library(libavutil_channel_layout OBJECT ${AV_DIR}channel_layout.c)
target_include_directories(libavutil_channel_layout 
	PRIVATE ${FFMPEG_CONFIG_HEADER_DIR} 
	PRIVATE ${FFMPEG_DIR}
	PRIVATE ${AV_DIR}
)
target_link_libraries(libavutil libavutil_channel_layout)

if ( FFMPEG_CONFIG_CUDA )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_cuda.c
	)
endif()

if ( FFMPEG_CONFIG_D3D11VA )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_d3d11va.c
	)
endif()

if ( FFMPEG_CONFIG_DXVA2 )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_dxva2.c
	)
endif()

if ( FFMPEG_CONFIG_LIBDRM )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_drm.c
	)
endif()

if ( FFMPEG_CONFIG_MACOS_KPERF )
	list(APPEND device_srcs
		${AV_DIR}macos_kperf.c
	)
endif()

if ( FFMPEG_CONFIG_MEDIACODEC )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_mediacodec.c
	)
endif()

if ( FFMPEG_CONFIG_OPENCL )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_opencl.c
	)
endif()

if ( FFMPEG_CONFIG_QSV )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_qsv.c
	)
endif()

if ( FFMPEG_CONFIG_VAAPI )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_vaapi.c
	)
endif()

if ( FFMPEG_CONFIG_VIDEOTOOLBOX )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_videotoolbox.c
	)
endif()

if ( FFMPEG_CONFIG_VDPAU )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_vdpau.c
	)
endif()

if ( FFMPEG_CONFIG_VULKAN )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_vulkan.c
	)
endif()


if ( FFMPEG_!CONFIG_VULKAN )
	list(APPEND device_srcs
		${AV_DIR}hwcontext_stub.c
	)
endif()


list(REMOVE_DUPLICATES device_srcs)

target_include_directories(libavutil 
	PRIVATE ${AV_DIR}
	PRIVATE ${FFMPEG_CONFIG_HEADER_DIR}
	PRIVATE ${FFMPEG_DIR}
)
target_link_directories(libavutil 
	PRIVATE ${AV_DIR}
	PRIVATE ${FFMPEG_CONFIG_HEADER_DIR}
	PRIVATE ${FFMPEG_DIR}
)

IF( device_srcs )
  add_library(libavutil_aux OBJECT ${device_srcs})
  target_include_directories(libavutil_aux 
		PRIVATE ${FFMPEG_CONFIG_HEADER_DIR} 
		PRIVATE ${FFMPEG_DIR}
	)
	target_link_directories(libavutil_aux 
		PRIVATE ${FFMPEG_CONFIG_HEADER_DIR}
		PRIVATE ${AV_DIR}
	)
  target_link_libraries(libavutil libavutil_aux)
ENDIF()

list(APPEND EXTRA_LIBS libavutil)