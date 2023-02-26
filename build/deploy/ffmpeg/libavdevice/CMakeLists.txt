cmake_minimum_required(VERSION 3.22)

message(VAR(libavdevice) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})
# copy makefile in libdevice
# generate a config.h
# generate a config_components h

# store component flags in file
# build source list based on flags

SET(AV_DIR ./ffmpeg/libavdevice/)

# HEADERS = avdevice.h
#           version.h                                                     \
#           version_major.h     

add_library(libavdevice STATIC
	alldevices.c
	avdevice.c
	utils.c
	version.c
)

if ( HAVE_LIBC_MSVCRT )
	list(APPEND device_srcs
		file_open.c
	)
endif()


# input/output devices
if ( CONFIG_ALSA_INDEV )
	list(APPEND device_srcs
		alsa_dec.c
		alsa.c
		timefilter.c
	)
endif()

if ( CONFIG_ALSA_OUTDEV )
	list(APPEND device_srcs
		alsa_enc.c
		alsa.c
	)
endif()

if ( CONFIG_ANDROID_CAMERA_INDEV )
	list(APPEND device_srcs
		android_camera.c
	)
endif()

if ( CONFIG_AUDIOTOOLBOX_OUTDEV )
	list(APPEND device_srcs
		audiotoolbox.c
	)
endif()

if ( CONFIG_AVFOUNDATION_INDEV )
	list(APPEND device_srcs
		avfoundation.c
	)
endif()

if ( CONFIG_BKTR_INDEV )
	list(APPEND device_srcs
		bktr.c
	)
endif()

if ( CONFIG_CACA_OUTDEV )
	list(APPEND device_srcs
		caca.c
	)
endif()

if ( CONFIG_DECKLINK_OUTDEV )
	list(APPEND device_srcs
		decklink_enc.c
		decklink_enc_c.c
		decklink_common.c
	)
endif()

if ( CONFIG_DECKLINK_INDEV )
	list(APPEND device_srcs
		decklink_dec.c
		decklink_dec_c.c
		decklink_common.c
	)
endif()

if ( CONFIG_DSHOW_INDEV )
	list(APPEND device_srcs
		dshow_crossbar.c
		dshow.c
		dshow_enummediatypes.c
		dshow_enumpins.c
		dshow_filter.c
		dshow_pin.c
		dshow_common.c
	)
endif()

if ( CONFIG_FBDEV_INDEV )
	list(APPEND device_srcs
		fbdev_dec.c
		fbdev_common.c
	)
endif()

if ( CONFIG_FBDEV_OUTDEV )
	list(APPEND device_srcs
		fbdev_enc.c
		fbdev_common.c
	)
endif()

if ( CONFIG_GDIGRAB_INDEV )
	list(APPEND device_srcs
		gdigrab.c
	)
endif()

if ( CONFIG_IEC61883_INDEV )
	list(APPEND device_srcs
		iec61883.c
	)
endif()

if ( CONFIG_JACK_INDEV )
	list(APPEND device_srcs
		jack.c
		timefilter.c
	)
endif()

if ( CONFIG_KMSGRAB_INDEV )
	list(APPEND device_srcs
		kmsgrab.c
	)
endif()

if ( CONFIG_LAVFI_INDEV )
	list(APPEND device_srcs
		lavfi.c
	)
endif()

if ( CONFIG_OPENAL_INDEV )
	list(APPEND device_srcs
		openal-dec.c
	)
endif()

if ( CONFIG_OPENGL_OUTDEV )
	list(APPEND device_srcs
		opengl_enc.c
	)
endif()

if ( CONFIG_OSS_INDEV )
	list(APPEND device_srcs
		oss_dec.c
		oss.c
	)
endif()

if ( CONFIG_OSS_OUTDEV )
	list(APPEND device_srcs
		oss_enc.c
		oss.c
	)
endif()

if ( CONFIG_PULSE_INDEV )
	list(APPEND device_srcs
		pulse_audio_dec.c
		pulse_audio_common.c
		timefilter.c
	)
endif()

if ( CONFIG_PULSE_OUTDEV )
	list(APPEND device_srcs
		pulse_audio_enc.c
		pulse_audio_common.c
	)
endif()

if ( CONFIG_SDL2_OUTDEV )
	list(APPEND device_srcs
		sdl2.c
	)
endif()

if ( CONFIG_SNDIO_INDEV )
	list(APPEND device_srcs
		sndio_dec.c
		sndio.c
	)
endif()

if ( CONFIG_SNDIO_OUTDEV )
	list(APPEND device_srcs
		sndio_enc.c
		sndio.c
	)
endif()

if ( CONFIG_V4L2_INDEV )
	list(APPEND device_srcs
		v4l2.c
		v4l2-common.c
		timefilter.c
	)
endif()

if ( CONFIG_V4L2_OUTDEV )
	list(APPEND device_srcs
		v4l2enc.c
		v4l2-common.c
	)
endif()

if ( CONFIG_VFWCAP_INDEV )
	list(APPEND device_srcs
		vfwcap.c
	)
endif()

if ( CONFIG_XCBGRAB_INDEV )
	list(APPEND device_srcs
		xcbgrab.c
	)
endif()

if ( CONFIG_XV_OUTDEV )
	list(APPEND device_srcs
		xv.c
	)
endif()


# external libraries
if ( CONFIG_LIBCDIO_INDEV )
	list(APPEND device_srcs
		libcdio.c
	)
endif()

if ( CONFIG_LIBDC1394_INDEV )
	list(APPEND device_srcs
		libdc1394.c
	)
endif()

list(REMOVE_DUPLICATES device_srcs)

target_include_directories(libavdevice PRIVATE ${FFMPEG_CONFIG_HEADER_DIR})

IF( device_srcs )
  add_library(libavdevice_aux1 OBJECT ${device_srcs})
  target_include_directories(libavdevice_aux1 PRIVATE ${FFMPEG_CONFIG_HEADER_DIR})
  target_link_libraries(libavdevice libavdevice_aux1)
ENDIF()

list(APPEND EXTRA_LIBS libavdevice)