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
#           version_major.h                                               \

add_library(libavdevice STATIC
  ${AV_DIR}alldevices.c
  ${AV_DIR}avdevice.c
  ${AV_DIR}utils.c
  ${AV_DIR}version.c
)

target_include_directories(libavdevice
  INTERFACE ${AV_DIR}
)

set(device_srcs)

if (FFMPEG_HAVE_LIBC_MSVCRT) 
  list(APPEND device_srcs ${AV_DIR}file_open.c)
endif()

# input/output devices
if (FFMPEG_CONFIG_ALSA_INDEV) 
  list(APPEND device_srcs 
    ${AV_DIR}alsa_dec.c
    ${AV_DIR}alsa.c
    ${AV_DIR}timefilter.c
  )
endif()

if (FFMPEG_CONFIG_ALSA_OUTDEV) 
  list(APPEND device_srcs
    ${AV_DIR}alsa_enc.c
    ${AV_DIR}alsa.c
  )
endif()

if (FFMPEG_CONFIG_ANDROID_CAMERA_INDEV) 
  list(APPEND device_srcs
    ${AV_DIR}android_camera.c
  )
endif()

if (FFMPEG_CONFIG_AUDIOTOOLBOX_OUTDEV) 
  list(APPEND device_srcs
    ${AV_DIR}audiotoolbox.c
  )
endif()

if (FFMPEG_CONFIG_AVFOUNDATION_INDEV) 
  list(APPEND device_srcs
    ${AV_DIR}avfoundation.c
  )
endif()

if (FFMPEG_CONFIG_BKTR_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}bktr.c
  )
endif()

if (FFMPEG_CONFIG_CACA_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}caca.c
  )
endif()

if (FFMPEG_CONFIG_DECKLINK_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}decklink_enc.c
    ${AV_DIR}decklink_enc_c.c
    ${AV_DIR}decklink_common.c
  )
endif()

if (FFMPEG_CONFIG_DECKLINK_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}decklink_dec.c
    ${AV_DIR}decklink_dec_c.c
    ${AV_DIR}decklink_common.c
  )
endif()

if (FFMPEG_CONFIG_DSHOW_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}dshow_crossbar.c
    ${AV_DIR}dshow.c
    ${AV_DIR}dshow_enummediatypes.c
    ${AV_DIR}dshow_enumpins.c
    ${AV_DIR}dshow_filter.c
    ${AV_DIR}dshow_pin.c
    ${AV_DIR}dshow_common.c
  )
endif()

if (FFMPEG_CONFIG_FBDEV_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}fbdev_dec.c
    ${AV_DIR}fbdev_common.c
  )
endif()

if (FFMPEG_CONFIG_GDIGRAB_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}gdigrab.c
  )
endif()

if (FFMPEG_CONFIG_IEC61883_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}iec61883.c
  )
endif()

if (FFMPEG_CONFIG_JACK_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}jack.c
    ${AV_DIR}timefilter.c
  )
endif()

if (FFMPEG_CONFIG_KMSGRAB_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}kmsgrab.c
  )
endif()

if (FFMPEG_CONFIG_LAVFI_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}lavfi.c
  )
endif()

if (FFMPEG_CONFIG_OPENAL_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}openal-dec.c
  )
endif()

if (FFMPEG_CONFIG_OPENGL_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}opengl_enc.c
  )
endif()

if (FFMPEG_----- ) 
  list(APPEND device_srcs
    ${AV_DIR}avfoundation.c
  )
endif()

# if (FFMPEG_----- ) 
#   list(APPEND device_srcs
#     ${AV_DIR}avfoundation.c
#   )
# endif()

if (FFMPEG_CONFIG_OSS_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}oss_dec.c
    ${AV_DIR}oss.c
  )
endif()

if (FFMPEG_CONFIG_OSS_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}oss_enc.c
    ${AV_DIR}oss.c
  )
endif()

if (FFMPEG_CONFIG_PULSE_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}pulse_audio_dec.c
    ${AV_DIR}pulse_audio_common.c
    ${AV_DIR}timefilter.c
  )
endif()

if (FFMPEG_CONFIG_PULSE_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}pulse_audio_enc.c
    ${AV_DIR}pulse_audio_common.c
  )
endif()

if (FFMPEG_CONFIG_SDL2_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}sdl2.c
  )
endif()

if (FFMPEG_CONFIG_SNDIO_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}sndio_dec.c
    ${AV_DIR}sndio.c
  )
endif()

if (FFMPEG_CONFIG_SNDIO_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}sndio_enc.c
    ${AV_DIR}sndio.c
  )
endif()

if (FFMPEG_CONFIG_V4L2_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}v4l2.c
    ${AV_DIR}v4l2-common.c
    ${AV_DIR}timefilter.c
  )
endif()

if (FFMPEG_CONFIG_V4L2_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}v4l2enc.c
    ${AV_DIR}v4l2-common.c
  )
endif()


if (FFMPEG_CONFIG_VFWCAP_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}vfwcap.c
  )
endif()

if (FFMPEG_CONFIG_XCBGRAB_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}xcbgrab.c
  )
endif()

if (FFMPEG_CONFIG_XV_OUTDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}xv.c
  )
endif()

if (FFMPEG_CONFIG_LIBCDIO_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}libcdio.c
  )
endif()

if (FFMPEG_CONFIG_LIBDC1394_INDEV ) 
  list(APPEND device_srcs
    ${AV_DIR}libdc1394.c
  )
endif()

list(REMOVE_DUPLICATES device_srcs)

target_include_directories(libavdevice PRIVATE ${FFMPEG_CONFIG_HEADER_DIR})

IF( device_srcs )
  add_library(libavdevice_aux OBJECT ${device_srcs})
  target_include_directories(libavdevice_aux PRIVATE ${FFMPEG_CONFIG_HEADER_DIR})
  target_link_libraries(libavdevice libavdevice_aux)
ENDIF()

list(APPEND EXTRA_LIBS libavdevice)