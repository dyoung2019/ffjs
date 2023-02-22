cmake_minimum_required(VERSION 3.22)

message(VAR(libavfilter) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

SET(AV_DIR ./ffmpeg/libavfilter/)

add_library(libavfilter STATIC
	${AV_DIR}avfilter.h 
	${AV_DIR}buffersink.h        
	${AV_DIR}buffersrc.h 
	${AV_DIR}version.h
	${AV_DIR}version_major.h  
	${AV_DIR}internal.h 
	#SRCS
  ${AV_DIR}allfilters.c
  ${AV_DIR}audio.c
  ${AV_DIR}avfilter.c
  ${AV_DIR}avfiltergraph.c
  ${AV_DIR}buffersink.c 
  ${AV_DIR}buffersrc.c
  ${AV_DIR}colorspace.c 
  ${AV_DIR}drawutils.c
  ${AV_DIR}fifo.c 
  ${AV_DIR}formats.c
  ${AV_DIR}framepool.c
  ${AV_DIR}framequeue.c 
  ${AV_DIR}graphdump.c
  ${AV_DIR}graphparser.c
  ${AV_DIR}version.c
  ${AV_DIR}video.c
)

target_include_directories(libavfilter
  INTERFACE ${AV_DIR}
)

target_include_directories(libavfilter
  PRIVATE ${AV_DIR}
)

set(device_srcs)

# if (FFMPEG_----- ) 
#   list(APPEND device_srcs
#     ${AV_DIR}avfoundation.c
#   )
# endif()

if (FFMPEG_HAVE_LIBC_MSVCRT ) 
  list(APPEND device_srcs
    ${AV_DIR}file_open.c
  )
endif()

set(DNN_DIR ${AV_DIR}dnn/)

if (FFMPEG_CONFIG_DNN )

  list(APPEND device_srcs
    ${AV_DIR}dnn_filter_common.c
    # dnn/Makefile
    ${DNN_DIR}dnn_interface.c
    ${DNN_DIR}dnn_io_proc.c
    ${DNN_DIR}queue.c
    ${DNN_DIR}safe_queue.c
    ${DNN_DIR}dnn_backend_common.c
    ${DNN_DIR}dnn_backend_native.c
    ${DNN_DIR}dnn_backend_native_layers.c
    ${DNN_DIR}dnn_backend_native_layer_avgpool.c
    ${DNN_DIR}dnn_backend_native_layer_dense.c
    ${DNN_DIR}dnn_backend_native_layer_pad.c
    ${DNN_DIR}dnn_backend_native_layer_conv2d.c
    ${DNN_DIR}dnn_backend_native_layer_depth2space.c
    ${DNN_DIR}dnn_backend_native_layer_maximum.c
    ${DNN_DIR}dnn_backend_native_layer_mathbinary.c
    ${DNN_DIR}dnn_backend_native_layer_mathunary.c
  )

  if (FFMPEG_CONFIG_LIBTENSORFLOW )
    list(APPEND device_srcs
      ${DNN_DIR}dnn_backend_tf.c
    )
  endif()

  if (FFMPEG_CONFIG_LIBOPENVINO ) 
    list(APPEND device_srcs
      ${DNN_DIR}dnn_backend_openvino.c
    )
  endif()

endif()

if ( FFMPEG_HAVE_THREADS )
	list(APPEND device_srcs
		${AV_DIR}pthread.c
	)
endif()

# subsystems
if ( FFMPEG_CONFIG_QSVVPP )
	list(APPEND device_srcs
		${AV_DIR}qsvvpp.c
	)
endif()

if ( FFMPEG_CONFIG_SCENE_SAD )
	list(APPEND device_srcs
		${AV_DIR}scene_sad.c
	)
endif()

if ( FFMPEG_CONFIG_DNN )
	list(APPEND device_srcs
		${AV_DIR}dnn_filter_common.c
	)
endif()

# audio filters
if ( FFMPEG_CONFIG_ABENCH_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_bench.c
	)
endif()

if ( FFMPEG_CONFIG_ACOMPRESSOR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_sidechaincompress.c
	)
endif()

if ( FFMPEG_CONFIG_ACONTRAST_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_acontrast.c
	)
endif()

if ( FFMPEG_CONFIG_ACOPY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_acopy.c
	)
endif()

if ( FFMPEG_CONFIG_ACROSSFADE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_afade.c
	)
endif()

if ( FFMPEG_CONFIG_ACROSSOVER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_acrossover.c
	)
endif()

if ( FFMPEG_CONFIG_ACRUSHER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_acrusher.c
	)
endif()

if ( FFMPEG_CONFIG_ACUE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_cue.c
	)
endif()

if ( FFMPEG_CONFIG_ADECLICK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_adeclick.c
	)
endif()

if ( FFMPEG_CONFIG_ADECLIP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_adeclick.c
	)
endif()

if ( FFMPEG_CONFIG_ADECORRELATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_adecorrelate.c
	)
endif()

if ( FFMPEG_CONFIG_ADELAY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_adelay.c
	)
endif()

if ( FFMPEG_CONFIG_ADENORM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_adenorm.c
	)
endif()

if ( FFMPEG_CONFIG_ADERIVATIVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aderivative.c
	)
endif()

if ( FFMPEG_CONFIG_ADYNAMICEQUALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_adynamicequalizer.c
	)
endif()

if ( FFMPEG_CONFIG_ADYNAMICSMOOTH_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_adynamicsmooth.c
	)
endif()

if ( FFMPEG_CONFIG_AECHO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aecho.c
	)
endif()

if ( FFMPEG_CONFIG_AEMPHASIS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aemphasis.c
	)
endif()

if ( FFMPEG_CONFIG_AEVAL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}aeval.c
	)
endif()

if ( FFMPEG_CONFIG_AEXCITER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aexciter.c
	)
endif()

if ( FFMPEG_CONFIG_AFADE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_afade.c
	)
endif()

if ( FFMPEG_CONFIG_AFFTDN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_afftdn.c
	)
endif()

if ( FFMPEG_CONFIG_AFFTFILT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_afftfilt.c
	)
endif()

if ( FFMPEG_CONFIG_AFIR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_afir.c
	)
endif()

if ( FFMPEG_CONFIG_AFORMAT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aformat.c
	)
endif()

if ( FFMPEG_CONFIG_AFREQSHIFT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_afreqshift.c
	)
endif()

if ( FFMPEG_CONFIG_AFWTDN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_afwtdn.c
	)
endif()

if ( FFMPEG_CONFIG_AGATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_agate.c
	)
endif()

if ( FFMPEG_CONFIG_AIIR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aiir.c
	)
endif()

if ( FFMPEG_CONFIG_AINTEGRAL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aderivative.c
	)
endif()

if ( FFMPEG_CONFIG_AINTERLEAVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_interleave.c
	)
endif()

if ( FFMPEG_CONFIG_ALATENCY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_latency.c
	)
endif()

if ( FFMPEG_CONFIG_ALIMITER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_alimiter.c
	)
endif()

if ( FFMPEG_CONFIG_ALLPASS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_ALOOP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_loop.c
	)
endif()

if ( FFMPEG_CONFIG_AMERGE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_amerge.c
	)
endif()

if ( FFMPEG_CONFIG_AMETADATA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_metadata.c
	)
endif()

if ( FFMPEG_CONFIG_AMIX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_amix.c
	)
endif()

if ( FFMPEG_CONFIG_AMULTIPLY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_amultiply.c
	)
endif()

if ( FFMPEG_CONFIG_ANEQUALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_anequalizer.c
	)
endif()

if ( FFMPEG_CONFIG_ANLMDN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_anlmdn.c
	)
endif()

if ( FFMPEG_CONFIG_ANLMF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_anlms.c
	)
endif()

if ( FFMPEG_CONFIG_ANLMS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_anlms.c
	)
endif()

if ( FFMPEG_CONFIG_ANULL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_anull.c
	)
endif()

if ( FFMPEG_CONFIG_APAD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_apad.c
	)
endif()

if ( FFMPEG_CONFIG_APERMS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_perms.c
	)
endif()

if ( FFMPEG_CONFIG_APHASER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aphaser.c
		${AV_DIR}generate_wave_table.c
	)
endif()

if ( FFMPEG_CONFIG_APHASESHIFT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_afreqshift.c
	)
endif()

if ( FFMPEG_CONFIG_APSYCLIP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_apsyclip.c
	)
endif()

if ( FFMPEG_CONFIG_APULSATOR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_apulsator.c
	)
endif()

if ( FFMPEG_CONFIG_AREALTIME_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_realtime.c
	)
endif()

if ( FFMPEG_CONFIG_ARESAMPLE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aresample.c
	)
endif()

if ( FFMPEG_CONFIG_AREVERSE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_reverse.c
	)
endif()

if ( FFMPEG_CONFIG_ARNNDN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_arnndn.c
	)
endif()

if ( FFMPEG_CONFIG_ASDR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asdr.c
	)
endif()

if ( FFMPEG_CONFIG_ASEGMENT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_segment.c
	)
endif()

if ( FFMPEG_CONFIG_ASELECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_select.c
	)
endif()

if ( FFMPEG_CONFIG_ASENDCMD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_sendcmd.c
	)
endif()

if ( FFMPEG_CONFIG_ASETNSAMPLES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asetnsamples.c
	)
endif()

if ( FFMPEG_CONFIG_ASETPTS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}setpts.c
	)
endif()

if ( FFMPEG_CONFIG_ASETRATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asetrate.c
	)
endif()

if ( FFMPEG_CONFIG_ASETTB_FILTER )
	list(APPEND device_srcs
		${AV_DIR}settb.c
	)
endif()

if ( FFMPEG_CONFIG_ASHOWINFO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_ashowinfo.c
	)
endif()

if ( FFMPEG_CONFIG_ASIDEDATA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_sidedata.c
	)
endif()

if ( FFMPEG_CONFIG_ASOFTCLIP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asoftclip.c
	)
endif()

if ( FFMPEG_CONFIG_ASPECTRALSTATS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_aspectralstats.c
	)
endif()

if ( FFMPEG_CONFIG_ASPLIT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}split.c
	)
endif()

if ( FFMPEG_CONFIG_ASR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asr.c
	)
endif()

if ( FFMPEG_CONFIG_ASTATS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_astats.c
	)
endif()

if ( FFMPEG_CONFIG_ASTREAMSELECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_streamselect.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_ASUBBOOST_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asubboost.c
	)
endif()

if ( FFMPEG_CONFIG_ASUBCUT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asupercut.c
	)
endif()

if ( FFMPEG_CONFIG_ASUPERCUT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asupercut.c
	)
endif()

if ( FFMPEG_CONFIG_ASUPERPASS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asupercut.c
	)
endif()

if ( FFMPEG_CONFIG_ASUPERSTOP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_asupercut.c
	)
endif()

if ( FFMPEG_CONFIG_ATEMPO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_atempo.c
	)
endif()

if ( FFMPEG_CONFIG_ATILT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_atilt.c
	)
endif()

if ( FFMPEG_CONFIG_ATRIM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}trim.c
	)
endif()

if ( FFMPEG_CONFIG_AXCORRELATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_axcorrelate.c
	)
endif()

if ( FFMPEG_CONFIG_AZMQ_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_zmq.c
	)
endif()

if ( FFMPEG_CONFIG_BANDPASS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_BANDREJECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_BASS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_BIQUAD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_BS2B_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_bs2b.c
	)
endif()

if ( FFMPEG_CONFIG_CHANNELMAP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_channelmap.c
	)
endif()

if ( FFMPEG_CONFIG_CHANNELSPLIT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_channelsplit.c
	)
endif()

if ( FFMPEG_CONFIG_CHORUS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_chorus.c
		${AV_DIR}generate_wave_table.c
	)
endif()

if ( FFMPEG_CONFIG_COMPAND_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_compand.c
	)
endif()

if ( FFMPEG_CONFIG_COMPENSATIONDELAY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_compensationdelay.c
	)
endif()

if ( FFMPEG_CONFIG_CROSSFEED_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_crossfeed.c
	)
endif()

if ( FFMPEG_CONFIG_CRYSTALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_crystalizer.c
	)
endif()

if ( FFMPEG_CONFIG_DCSHIFT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_dcshift.c
	)
endif()

if ( FFMPEG_CONFIG_DEESSER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_deesser.c
	)
endif()

if ( FFMPEG_CONFIG_DIALOGUENHANCE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_dialoguenhance.c
	)
endif()

if ( FFMPEG_CONFIG_DRMETER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_drmeter.c
	)
endif()

if ( FFMPEG_CONFIG_DYNAUDNORM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_dynaudnorm.c
	)
endif()

if ( FFMPEG_CONFIG_EARWAX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_earwax.c
	)
endif()

if ( FFMPEG_CONFIG_EBUR128_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_ebur128.c
	)
endif()

if ( FFMPEG_CONFIG_EQUALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_EXTRASTEREO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_extrastereo.c
	)
endif()

if ( FFMPEG_CONFIG_FIREQUALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_firequalizer.c
	)
endif()

if ( FFMPEG_CONFIG_FLANGER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_flanger.c
		${AV_DIR}generate_wave_table.c
	)
endif()

if ( FFMPEG_CONFIG_HAAS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_haas.c
	)
endif()

if ( FFMPEG_CONFIG_HDCD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_hdcd.c
	)
endif()

if ( FFMPEG_CONFIG_HEADPHONE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_headphone.c
	)
endif()

if ( FFMPEG_CONFIG_HIGHPASS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_HIGHSHELF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_JOIN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_join.c
	)
endif()

if ( FFMPEG_CONFIG_LADSPA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_ladspa.c
	)
endif()

if ( FFMPEG_CONFIG_LOUDNORM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_loudnorm.c
		${AV_DIR}ebur128.c
	)
endif()

if ( FFMPEG_CONFIG_LOWPASS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_LOWSHELF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_LV2_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_lv2.c
	)
endif()

if ( FFMPEG_CONFIG_MCOMPAND_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_mcompand.c
	)
endif()

if ( FFMPEG_CONFIG_PAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_pan.c
	)
endif()

if ( FFMPEG_CONFIG_REPLAYGAIN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_replaygain.c
	)
endif()

if ( FFMPEG_CONFIG_RUBBERBAND_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_rubberband.c
	)
endif()

if ( FFMPEG_CONFIG_SIDECHAINCOMPRESS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_sidechaincompress.c
	)
endif()

if ( FFMPEG_CONFIG_SIDECHAINGATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_agate.c
	)
endif()

if ( FFMPEG_CONFIG_SILENCEDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_silencedetect.c
	)
endif()

if ( FFMPEG_CONFIG_SILENCEREMOVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_silenceremove.c
	)
endif()

if ( FFMPEG_CONFIG_SOFALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_sofalizer.c
	)
endif()

if ( FFMPEG_CONFIG_SPEECHNORM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_speechnorm.c
	)
endif()

if ( FFMPEG_CONFIG_STEREOTOOLS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_stereotools.c
	)
endif()

if ( FFMPEG_CONFIG_STEREOWIDEN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_stereowiden.c
	)
endif()

if ( FFMPEG_CONFIG_SUPEREQUALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_superequalizer.c
	)
endif()

if ( FFMPEG_CONFIG_SURROUND_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_surround.c
	)
endif()

if ( FFMPEG_CONFIG_TREBLE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_biquads.c
	)
endif()

if ( FFMPEG_CONFIG_TREMOLO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_tremolo.c
	)
endif()

if ( FFMPEG_CONFIG_VIBRATO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_vibrato.c
		${AV_DIR}generate_wave_table.c
	)
endif()

if ( FFMPEG_CONFIG_VIRTUALBASS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_virtualbass.c
	)
endif()

if ( FFMPEG_CONFIG_VOLUME_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_volume.c
	)
endif()

if ( FFMPEG_CONFIG_VOLUMEDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}af_volumedetect.c
	)
endif()


if ( FFMPEG_CONFIG_AEVALSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}aeval.c
	)
endif()

if ( FFMPEG_CONFIG_AFIRSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}asrc_afirsrc.c
	)
endif()

if ( FFMPEG_CONFIG_ANOISESRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}asrc_anoisesrc.c
	)
endif()

if ( FFMPEG_CONFIG_ANULLSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}asrc_anullsrc.c
	)
endif()

if ( FFMPEG_CONFIG_FLITE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}asrc_flite.c
	)
endif()

if ( FFMPEG_CONFIG_HILBERT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}asrc_hilbert.c
	)
endif()

if ( FFMPEG_CONFIG_SINC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}asrc_sinc.c
	)
endif()

if ( FFMPEG_CONFIG_SINE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}asrc_sine.c
	)
endif()


if ( FFMPEG_CONFIG_ANULLSINK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}asink_anullsink.c
	)
endif()


# video filters
if ( FFMPEG_CONFIG_ADDROI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_addroi.c
	)
endif()

if ( FFMPEG_CONFIG_ALPHAEXTRACT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_extractplanes.c
	)
endif()

if ( FFMPEG_CONFIG_ALPHAMERGE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_alphamerge.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_AMPLIFY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_amplify.c
	)
endif()

if ( FFMPEG_CONFIG_ASS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_subtitles.c
	)
endif()

if ( FFMPEG_CONFIG_ATADENOISE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_atadenoise.c
	)
endif()

if ( FFMPEG_CONFIG_AVGBLUR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_avgblur.c
	)
endif()

if ( FFMPEG_CONFIG_AVGBLUR_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_avgblur_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/avgblur.c
		${AV_DIR}boxblur.c
	)
endif()

if ( FFMPEG_CONFIG_AVGBLUR_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_avgblur_vulkan.c
		${AV_DIR}vulkan.c
		${AV_DIR}vulkan_filter.c
	)
endif()

if ( FFMPEG_CONFIG_BBOX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}bbox.c
		${AV_DIR}vf_bbox.c
	)
endif()

if ( FFMPEG_CONFIG_BENCH_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_bench.c
	)
endif()

if ( FFMPEG_CONFIG_BILATERAL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_bilateral.c
	)
endif()

if ( FFMPEG_CONFIG_BITPLANENOISE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_bitplanenoise.c
	)
endif()

if ( FFMPEG_CONFIG_BLACKDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_blackdetect.c
	)
endif()

if ( FFMPEG_CONFIG_BLACKFRAME_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_blackframe.c
	)
endif()

if ( FFMPEG_CONFIG_BLEND_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_blend.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_BLEND_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_blend_vulkan.c
		${AV_DIR}framesync.c
		${AV_DIR}vulkan.c
		${AV_DIR}vulkan_filter.c
	)
endif()

if ( FFMPEG_CONFIG_BLOCKDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_blockdetect.c
	)
endif()

if ( FFMPEG_CONFIG_BLURDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_blurdetect.c
		${AV_DIR}edge_common.c
	)
endif()

if ( FFMPEG_CONFIG_BM3D_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_bm3d.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_BOXBLUR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_boxblur.c
		${AV_DIR}boxblur.c
	)
endif()

if ( FFMPEG_CONFIG_BOXBLUR_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_avgblur_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/avgblur.c
		${AV_DIR}boxblur.c
	)
endif()

if ( FFMPEG_CONFIG_BWDIF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_bwdif.c
		${AV_DIR}yadif_common.c
	)
endif()

if ( FFMPEG_CONFIG_CAS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_cas.c
	)
endif()

if ( FFMPEG_CONFIG_CHROMABER_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_chromaber_vulkan.c
		${AV_DIR}vulkan.c
		${AV_DIR}vulkan_filter.c
	)
endif()

if ( FFMPEG_CONFIG_CHROMAHOLD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_chromakey.c
	)
endif()

if ( FFMPEG_CONFIG_CHROMAKEY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_chromakey.c
	)
endif()

if ( FFMPEG_CONFIG_CHROMAKEY_CUDA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_chromakey_cuda.c
		${AV_DIR}vf_chromakey_cuda.ptx.c
	)
endif()


if ( FFMPEG_CONFIG_CHROMANR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_chromanr.c
	)
endif()

if ( FFMPEG_CONFIG_CHROMASHIFT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_chromashift.c
	)
endif()

if ( FFMPEG_CONFIG_CIESCOPE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_ciescope.c
	)
endif()

if ( FFMPEG_CONFIG_CODECVIEW_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_codecview.c
		${AV_DIR}qp_table.c
	)
endif()

if ( FFMPEG_CONFIG_COLORBALANCE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorbalance.c
	)
endif()

if ( FFMPEG_CONFIG_COLORCHANNELMIXER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorchannelmixer.c
	)
endif()

if ( FFMPEG_CONFIG_COLORCONTRAST_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorcontrast.c
	)
endif()

if ( FFMPEG_CONFIG_COLORCORRECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorcorrect.c
	)
endif()

if ( FFMPEG_CONFIG_COLORIZE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorize.c
	)
endif()

if ( FFMPEG_CONFIG_COLORKEY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorkey.c
	)
endif()

if ( FFMPEG_CONFIG_COLORKEY_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorkey_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/colorkey.c
	)
endif()

if ( FFMPEG_CONFIG_COLORHOLD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorkey.c
	)
endif()

if ( FFMPEG_CONFIG_COLORLEVELS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorlevels.c
	)
endif()

if ( FFMPEG_CONFIG_COLORMAP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colormap.c
	)
endif()

if ( FFMPEG_CONFIG_COLORMATRIX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colormatrix.c
	)
endif()

if ( FFMPEG_CONFIG_COLORSPACE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorspace.c
		${AV_DIR}colorspacedsp.c
	)
endif()

if ( FFMPEG_CONFIG_COLORTEMPERATURE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colortemperature.c
	)
endif()

if ( FFMPEG_CONFIG_CONVOLUTION_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution.c
	)
endif()

if ( FFMPEG_CONFIG_CONVOLUTION_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/convolution.c
	)
endif()

if ( FFMPEG_CONFIG_CONVOLVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolve.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_COPY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_copy.c
	)
endif()

if ( FFMPEG_CONFIG_COREIMAGE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_coreimage.c
	)
endif()

if ( FFMPEG_CONFIG_COVER_RECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_cover_rect.c
		${AV_DIR}lavfutils.c
	)
endif()

if ( FFMPEG_CONFIG_CROP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_crop.c
	)
endif()

if ( FFMPEG_CONFIG_CROPDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_cropdetect.c
	)
endif()

if ( FFMPEG_CONFIG_CUE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_cue.c
	)
endif()

if ( FFMPEG_CONFIG_CURVES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_curves.c
	)
endif()

if ( FFMPEG_CONFIG_DATASCOPE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_datascope.c
	)
endif()

if ( FFMPEG_CONFIG_DBLUR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_dblur.c
	)
endif()

if ( FFMPEG_CONFIG_DCTDNOIZ_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_dctdnoiz.c
	)
endif()

if ( FFMPEG_CONFIG_DEBAND_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_deband.c
	)
endif()

if ( FFMPEG_CONFIG_DEBLOCK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_deblock.c
	)
endif()

if ( FFMPEG_CONFIG_DECIMATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_decimate.c
	)
endif()

if ( FFMPEG_CONFIG_DERAIN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_derain.c
	)
endif()

if ( FFMPEG_CONFIG_DECONVOLVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolve.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_DEDOT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_dedot.c
	)
endif()

if ( FFMPEG_CONFIG_DEFLATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_neighbor.c
	)
endif()

if ( FFMPEG_CONFIG_DEFLICKER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_deflicker.c
	)
endif()

if ( FFMPEG_CONFIG_DEINTERLACE_QSV_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_deinterlace_qsv.c
	)
endif()

if ( FFMPEG_CONFIG_DEINTERLACE_VAAPI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_deinterlace_vaapi.c
		${AV_DIR}vaapi_vpp.c
	)
endif()

if ( FFMPEG_CONFIG_DEJUDDER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_dejudder.c
	)
endif()

if ( FFMPEG_CONFIG_DELOGO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_delogo.c
	)
endif()

if ( FFMPEG_CONFIG_DENOISE_VAAPI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_misc_vaapi.c
		${AV_DIR}vaapi_vpp.c
	)
endif()

if ( FFMPEG_CONFIG_DESHAKE_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_deshake_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/deshake.c
		${AV_DIR}transform.c
	)
endif()

if ( FFMPEG_CONFIG_DESHAKE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_deshake.c
		${AV_DIR}transform.c
	)
endif()

if ( FFMPEG_CONFIG_DESPILL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_despill.c
	)
endif()

if ( FFMPEG_CONFIG_DETELECINE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_detelecine.c
	)
endif()

if ( FFMPEG_CONFIG_DILATION_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_neighbor.c
	)
endif()

if ( FFMPEG_CONFIG_DILATION_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_neighbor_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/neighbor.c
	)
endif()

if ( FFMPEG_CONFIG_DISPLACE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_displace.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_DNN_CLASSIFY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_dnn_classify.c
	)
endif()

if ( FFMPEG_CONFIG_DNN_DETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_dnn_detect.c
	)
endif()

if ( FFMPEG_CONFIG_DNN_PROCESSING_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_dnn_processing.c
	)
endif()

if ( FFMPEG_CONFIG_DOUBLEWEAVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_weave.c
	)
endif()

if ( FFMPEG_CONFIG_DRAWBOX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_drawbox.c
	)
endif()

if ( FFMPEG_CONFIG_DRAWGRAPH_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_drawgraph.c
	)
endif()

if ( FFMPEG_CONFIG_DRAWGRID_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_drawbox.c
	)
endif()

if ( FFMPEG_CONFIG_DRAWTEXT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_drawtext.c
	)
endif()

if ( FFMPEG_CONFIG_EDGEDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_edgedetect.c
		${AV_DIR}edge_common.c
	)
endif()

if ( FFMPEG_CONFIG_ELBG_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_elbg.c
	)
endif()

if ( FFMPEG_CONFIG_ENTROPY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_entropy.c
	)
endif()

if ( FFMPEG_CONFIG_EPX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_epx.c
	)
endif()

if ( FFMPEG_CONFIG_EQ_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_eq.c
	)
endif()

if ( FFMPEG_CONFIG_EROSION_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_neighbor.c
	)
endif()

if ( FFMPEG_CONFIG_EROSION_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_neighbor_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/neighbor.c
	)
endif()

if ( FFMPEG_CONFIG_ESTDIF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_estdif.c
	)
endif()

if ( FFMPEG_CONFIG_EXPOSURE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_exposure.c
	)
endif()

if ( FFMPEG_CONFIG_EXTRACTPLANES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_extractplanes.c
	)
endif()

if ( FFMPEG_CONFIG_FADE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fade.c
	)
endif()

if ( FFMPEG_CONFIG_FEEDBACK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_feedback.c
	)
endif()

if ( FFMPEG_CONFIG_FFTDNOIZ_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fftdnoiz.c
	)
endif()

if ( FFMPEG_CONFIG_FFTFILT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fftfilt.c
	)
endif()

if ( FFMPEG_CONFIG_FIELD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_field.c
	)
endif()

if ( FFMPEG_CONFIG_FIELDHINT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fieldhint.c
	)
endif()

if ( FFMPEG_CONFIG_FIELDMATCH_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fieldmatch.c
	)
endif()

if ( FFMPEG_CONFIG_FIELDORDER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fieldorder.c
	)
endif()

if ( FFMPEG_CONFIG_FILLBORDERS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fillborders.c
	)
endif()

if ( FFMPEG_CONFIG_FIND_RECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_find_rect.c
		${AV_DIR}lavfutils.c
	)
endif()

if ( FFMPEG_CONFIG_FLOODFILL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_floodfill.c
	)
endif()

if ( FFMPEG_CONFIG_FORMAT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_format.c
	)
endif()

if ( FFMPEG_CONFIG_FPS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fps.c
	)
endif()

if ( FFMPEG_CONFIG_FRAMEPACK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_framepack.c
	)
endif()

if ( FFMPEG_CONFIG_FRAMERATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_framerate.c
	)
endif()

if ( FFMPEG_CONFIG_FRAMESTEP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_framestep.c
	)
endif()

if ( FFMPEG_CONFIG_FREEZEDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_freezedetect.c
	)
endif()

if ( FFMPEG_CONFIG_FREEZEFRAMES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_freezeframes.c
	)
endif()

if ( FFMPEG_CONFIG_FREI0R_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_frei0r.c
	)
endif()

if ( FFMPEG_CONFIG_FSPP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_fspp.c
		${AV_DIR}qp_table.c
	)
endif()

if ( FFMPEG_CONFIG_GBLUR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_gblur.c
	)
endif()

if ( FFMPEG_CONFIG_GBLUR_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_gblur_vulkan.c
		${AV_DIR}vulkan.c
		${AV_DIR}vulkan_filter.c
	)
endif()

if ( FFMPEG_CONFIG_GEQ_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_geq.c
	)
endif()

if ( FFMPEG_CONFIG_GRADFUN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_gradfun.c
	)
endif()

if ( FFMPEG_CONFIG_GRAPHMONITOR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_graphmonitor.c
	)
endif()

if ( FFMPEG_CONFIG_GRAYWORLD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_grayworld.c
	)
endif()

if ( FFMPEG_CONFIG_GREYEDGE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_colorconstancy.c
	)
endif()

if ( FFMPEG_CONFIG_GUIDED_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_guided.c
	)
endif()

if ( FFMPEG_CONFIG_HALDCLUT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lut3d.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_HFLIP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hflip.c
	)
endif()

if ( FFMPEG_CONFIG_HFLIP_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_flip_vulkan.c
		${AV_DIR}vulkan.c
	)
endif()

if ( FFMPEG_CONFIG_HISTEQ_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_histeq.c
	)
endif()

if ( FFMPEG_CONFIG_HISTOGRAM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_histogram.c
	)
endif()

if ( FFMPEG_CONFIG_HQDN3D_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hqdn3d.c
	)
endif()

if ( FFMPEG_CONFIG_HQX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hqx.c
	)
endif()

if ( FFMPEG_CONFIG_HSTACK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_stack.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_HSVHOLD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hsvkey.c
	)
endif()

if ( FFMPEG_CONFIG_HSVKEY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hsvkey.c
	)
endif()

if ( FFMPEG_CONFIG_HUE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hue.c
	)
endif()

if ( FFMPEG_CONFIG_HUESATURATION_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_huesaturation.c
	)
endif()

if ( FFMPEG_CONFIG_HWDOWNLOAD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hwdownload.c
	)
endif()

if ( FFMPEG_CONFIG_HWMAP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hwmap.c
	)
endif()

if ( FFMPEG_CONFIG_HWUPLOAD_CUDA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hwupload_cuda.c
	)
endif()

if ( FFMPEG_CONFIG_HWUPLOAD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hwupload.c
	)
endif()

if ( FFMPEG_CONFIG_HYSTERESIS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_hysteresis.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_ICCDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_iccdetect.c
		${AV_DIR}fflcms2.c
	)
endif()

if ( FFMPEG_CONFIG_ICCGEN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_iccgen.c
		${AV_DIR}fflcms2.c
	)
endif()

if ( FFMPEG_CONFIG_IDENTITY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_identity.c
	)
endif()

if ( FFMPEG_CONFIG_IDET_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_idet.c
	)
endif()

if ( FFMPEG_CONFIG_IL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_il.c
	)
endif()

if ( FFMPEG_CONFIG_INFLATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_neighbor.c
	)
endif()

if ( FFMPEG_CONFIG_INTERLACE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_tinterlace.c
	)
endif()

if ( FFMPEG_CONFIG_INTERLEAVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_interleave.c
	)
endif()

if ( FFMPEG_CONFIG_KERNDEINT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_kerndeint.c
	)
endif()

if ( FFMPEG_CONFIG_KIRSCH_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution.c
	)
endif()

if ( FFMPEG_CONFIG_LAGFUN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lagfun.c
	)
endif()

if ( FFMPEG_CONFIG_LATENCY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_latency.c
	)
endif()

if ( FFMPEG_CONFIG_LENSCORRECTION_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lenscorrection.c
	)
endif()

if ( FFMPEG_CONFIG_LENSFUN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lensfun.c
	)
endif()

if ( FFMPEG_CONFIG_LIBPLACEBO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_libplacebo.c
		${AV_DIR}vulkan.c
		${AV_DIR}vulkan_filter.c
	)
endif()

if ( FFMPEG_CONFIG_LIBVMAF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_libvmaf.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_LIMITDIFF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_limitdiff.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_LIMITER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_limiter.c
	)
endif()

if ( FFMPEG_CONFIG_LOOP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_loop.c
	)
endif()

if ( FFMPEG_CONFIG_LUMAKEY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lumakey.c
	)
endif()

if ( FFMPEG_CONFIG_LUT1D_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lut3d.c
	)
endif()

if ( FFMPEG_CONFIG_LUT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lut.c
	)
endif()

if ( FFMPEG_CONFIG_LUT2_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lut2.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_LUT3D_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lut3d.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_LUTRGB_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lut.c
	)
endif()

if ( FFMPEG_CONFIG_LUTYUV_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lut.c
	)
endif()

if ( FFMPEG_CONFIG_MASKEDCLAMP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_maskedclamp.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_MASKEDMAX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_maskedminmax.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_MASKEDMERGE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_maskedmerge.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_MASKEDMIN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_maskedminmax.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_MASKEDTHRESHOLD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_maskedthreshold.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_MASKFUN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_maskfun.c
	)
endif()

if ( FFMPEG_CONFIG_MCDEINT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_mcdeint.c
	)
endif()

if ( FFMPEG_CONFIG_MEDIAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_median.c
	)
endif()

if ( FFMPEG_CONFIG_MERGEPLANES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_mergeplanes.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_MESTIMATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_mestimate.c
		${AV_DIR}motion_estimation.c
	)
endif()

if ( FFMPEG_CONFIG_METADATA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_metadata.c
	)
endif()

if ( FFMPEG_CONFIG_MIDEQUALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_midequalizer.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_MINTERPOLATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_minterpolate.c
		${AV_DIR}motion_estimation.c
	)
endif()

if ( FFMPEG_CONFIG_MIX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_mix.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_MONOCHROME_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_monochrome.c
	)
endif()

if ( FFMPEG_CONFIG_MORPHO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_morpho.c
	)
endif()

if ( FFMPEG_CONFIG_MPDECIMATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_mpdecimate.c
	)
endif()

if ( FFMPEG_CONFIG_MULTIPLY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_multiply.c
	)
endif()

if ( FFMPEG_CONFIG_NEGATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_negate.c
	)
endif()

if ( FFMPEG_CONFIG_NLMEANS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_nlmeans.c
	)
endif()

if ( FFMPEG_CONFIG_NLMEANS_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_nlmeans_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/nlmeans.c
	)
endif()

if ( FFMPEG_CONFIG_NNEDI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_nnedi.c
	)
endif()

if ( FFMPEG_CONFIG_NOFORMAT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_format.c
	)
endif()

if ( FFMPEG_CONFIG_NOISE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_noise.c
	)
endif()

if ( FFMPEG_CONFIG_NORMALIZE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_normalize.c
	)
endif()

if ( FFMPEG_CONFIG_NULL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_null.c
	)
endif()

if ( FFMPEG_CONFIG_OCR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_ocr.c
	)
endif()

if ( FFMPEG_CONFIG_OCV_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_libopencv.c
	)
endif()

if ( FFMPEG_CONFIG_OSCILLOSCOPE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_datascope.c
	)
endif()

if ( FFMPEG_CONFIG_OVERLAY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_overlay.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_OVERLAY_CUDA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_overlay_cuda.c
		${AV_DIR}framesync.c
		${AV_DIR}vf_overlay_cuda.ptx.c
		${AV_DIR}cuda/load_helper.c
	)
endif()

if ( FFMPEG_CONFIG_OVERLAY_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_overlay_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/overlay.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_OVERLAY_QSV_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_overlay_qsv.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_OVERLAY_VAAPI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_overlay_vaapi.c
		${AV_DIR}framesync.c
		${AV_DIR}vaapi_vpp.c
	)
endif()

if ( FFMPEG_CONFIG_OVERLAY_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_overlay_vulkan.c
		${AV_DIR}vulkan.c
		${AV_DIR}vulkan_filter.c
	)
endif()

if ( FFMPEG_CONFIG_OWDENOISE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_owdenoise.c
	)
endif()

if ( FFMPEG_CONFIG_PAD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_pad.c
	)
endif()

if ( FFMPEG_CONFIG_PAD_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_pad_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/pad.c
	)
endif()

if ( FFMPEG_CONFIG_PALETTEGEN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_palettegen.c
	)
endif()

if ( FFMPEG_CONFIG_PALETTEUSE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_paletteuse.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_PERMS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_perms.c
	)
endif()

if ( FFMPEG_CONFIG_PERSPECTIVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_perspective.c
	)
endif()

if ( FFMPEG_CONFIG_PHASE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_phase.c
	)
endif()

if ( FFMPEG_CONFIG_PHOTOSENSITIVITY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_photosensitivity.c
	)
endif()

if ( FFMPEG_CONFIG_PIXDESCTEST_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_pixdesctest.c
	)
endif()

if ( FFMPEG_CONFIG_PIXELIZE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_pixelize.c
	)
endif()

if ( FFMPEG_CONFIG_PIXSCOPE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_datascope.c
	)
endif()

if ( FFMPEG_CONFIG_PP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_pp.c
		${AV_DIR}qp_table.c
	)
endif()

if ( FFMPEG_CONFIG_PP7_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_pp7.c
		${AV_DIR}qp_table.c
	)
endif()

if ( FFMPEG_CONFIG_PREMULTIPLY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_premultiply.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_PREWITT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution.c
	)
endif()

if ( FFMPEG_CONFIG_PREWITT_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/convolution.c
	)
endif()

if ( FFMPEG_CONFIG_PROCAMP_VAAPI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_procamp_vaapi.c
		${AV_DIR}vaapi_vpp.c
	)
endif()

if ( FFMPEG_CONFIG_PROGRAM_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_program_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_PSEUDOCOLOR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_pseudocolor.c
	)
endif()

if ( FFMPEG_CONFIG_PSNR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_psnr.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_PULLUP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_pullup.c
	)
endif()

if ( FFMPEG_CONFIG_QP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_qp.c
	)
endif()

if ( FFMPEG_CONFIG_RANDOM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_random.c
	)
endif()

if ( FFMPEG_CONFIG_READEIA608_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_readeia608.c
	)
endif()

if ( FFMPEG_CONFIG_READVITC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_readvitc.c
	)
endif()

if ( FFMPEG_CONFIG_REALTIME_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_realtime.c
	)
endif()

if ( FFMPEG_CONFIG_REMAP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_remap.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_REMAP_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_remap_opencl.c
		${AV_DIR}framesync.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/remap.c
	)
endif()

if ( FFMPEG_CONFIG_REMOVEGRAIN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_removegrain.c
	)
endif()

if ( FFMPEG_CONFIG_REMOVELOGO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}bbox.c
		${AV_DIR}lswsutils.c
		${AV_DIR}lavfutils.c
		${AV_DIR}vf_removelogo.c
	)
endif()

if ( FFMPEG_CONFIG_REPEATFIELDS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_repeatfields.c
	)
endif()

if ( FFMPEG_CONFIG_REVERSE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_reverse.c
	)
endif()

if ( FFMPEG_CONFIG_RGBASHIFT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_chromashift.c
	)
endif()

if ( FFMPEG_CONFIG_ROBERTS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution.c
	)
endif()

if ( FFMPEG_CONFIG_ROBERTS_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/convolution.c
	)
endif()

if ( FFMPEG_CONFIG_ROTATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_rotate.c
	)
endif()

if ( FFMPEG_CONFIG_SAB_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_sab.c
	)
endif()

if ( FFMPEG_CONFIG_SCALE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scale.c
		${AV_DIR}scale_eval.c
	)
endif()

if ( FFMPEG_CONFIG_SCALE_CUDA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scale_cuda.c
		${AV_DIR}scale_eval.c
		${AV_DIR}vf_scale_cuda.ptx.c
		${AV_DIR}cuda/load_helper.c
	)
endif()

if ( FFMPEG_CONFIG_SCALE_NPP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scale_npp.c
		${AV_DIR}scale_eval.c
	)
endif()

if ( FFMPEG_CONFIG_SCALE_QSV_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scale_qsv.c
	)
endif()

if ( FFMPEG_CONFIG_SCALE_VAAPI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scale_vaapi.c
		${AV_DIR}scale_eval.c
		${AV_DIR}vaapi_vpp.c
	)
endif()

if ( FFMPEG_CONFIG_SCALE_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scale_vulkan.c
		${AV_DIR}vulkan.c
		${AV_DIR}vulkan_filter.c
	)
endif()

if ( FFMPEG_CONFIG_SCALE2REF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scale.c
		${AV_DIR}scale_eval.c
	)
endif()

if ( FFMPEG_CONFIG_SCALE2REF_NPP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scale_npp.c
		${AV_DIR}scale_eval.c
	)
endif()

if ( FFMPEG_CONFIG_SCDET_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scdet.c
	)
endif()

if ( FFMPEG_CONFIG_SCHARR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution.c
	)
endif()

if ( FFMPEG_CONFIG_SCROLL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_scroll.c
	)
endif()

if ( FFMPEG_CONFIG_SEGMENT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_segment.c
	)
endif()

if ( FFMPEG_CONFIG_SELECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_select.c
	)
endif()

if ( FFMPEG_CONFIG_SELECTIVECOLOR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_selectivecolor.c
	)
endif()

if ( FFMPEG_CONFIG_SENDCMD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_sendcmd.c
	)
endif()

if ( FFMPEG_CONFIG_SEPARATEFIELDS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_separatefields.c
	)
endif()

if ( FFMPEG_CONFIG_SETDAR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_aspect.c
	)
endif()

if ( FFMPEG_CONFIG_SETFIELD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_setparams.c
	)
endif()

if ( FFMPEG_CONFIG_SETPARAMS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_setparams.c
	)
endif()

if ( FFMPEG_CONFIG_SETPTS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}setpts.c
	)
endif()

if ( FFMPEG_CONFIG_SETRANGE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_setparams.c
	)
endif()

if ( FFMPEG_CONFIG_SETSAR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_aspect.c
	)
endif()

if ( FFMPEG_CONFIG_SETTB_FILTER )
	list(APPEND device_srcs
		${AV_DIR}settb.c
	)
endif()

if ( FFMPEG_CONFIG_SHARPEN_NPP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_sharpen_npp.c
	)
endif()

if ( FFMPEG_CONFIG_SHARPNESS_VAAPI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_misc_vaapi.c
		${AV_DIR}vaapi_vpp.c
	)
endif()

if ( FFMPEG_CONFIG_SHEAR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_shear.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWINFO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_showinfo.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWPALETTE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_showpalette.c
	)
endif()

if ( FFMPEG_CONFIG_SHUFFLEFRAMES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_shuffleframes.c
	)
endif()

if ( FFMPEG_CONFIG_SHUFFLEPIXELS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_shufflepixels.c
	)
endif()

if ( FFMPEG_CONFIG_SHUFFLEPLANES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_shuffleplanes.c
	)
endif()

if ( FFMPEG_CONFIG_SIDEDATA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_sidedata.c
	)
endif()

if ( FFMPEG_CONFIG_SIGNALSTATS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_signalstats.c
	)
endif()

if ( FFMPEG_CONFIG_SIGNATURE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_signature.c
	)
endif()

if ( FFMPEG_CONFIG_SMARTBLUR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_smartblur.c
	)
endif()

if ( FFMPEG_CONFIG_SOBEL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution.c
	)
endif()

if ( FFMPEG_CONFIG_SOBEL_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolution_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/convolution.c
	)
endif()

if ( FFMPEG_CONFIG_SITI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_siti.c
	)
endif()

if ( FFMPEG_CONFIG_SPLIT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}split.c
	)
endif()

if ( FFMPEG_CONFIG_SPP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_spp.c
		${AV_DIR}qp_table.c
	)
endif()

if ( FFMPEG_CONFIG_SR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_sr.c
	)
endif()

if ( FFMPEG_CONFIG_SSIM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_ssim.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_STEREO3D_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_stereo3d.c
	)
endif()

if ( FFMPEG_CONFIG_STREAMSELECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_streamselect.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_SUBTITLES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_subtitles.c
	)
endif()

if ( FFMPEG_CONFIG_SUPER2XSAI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_super2xsai.c
	)
endif()

if ( FFMPEG_CONFIG_SWAPRECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_swaprect.c
	)
endif()

if ( FFMPEG_CONFIG_SWAPUV_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_swapuv.c
	)
endif()

if ( FFMPEG_CONFIG_TBLEND_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_blend.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_TELECINE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_telecine.c
	)
endif()

if ( FFMPEG_CONFIG_THISTOGRAM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_histogram.c
	)
endif()

if ( FFMPEG_CONFIG_THRESHOLD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_threshold.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_THUMBNAIL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_thumbnail.c
	)
endif()

if ( FFMPEG_CONFIG_THUMBNAIL_CUDA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_thumbnail_cuda.c
		${AV_DIR}vf_thumbnail_cuda.ptx.c
		${AV_DIR}cuda/load_helper.c
	)
endif()

if ( FFMPEG_CONFIG_TILE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_tile.c
	)
endif()

if ( FFMPEG_CONFIG_TINTERLACE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_tinterlace.c
	)
endif()

if ( FFMPEG_CONFIG_TLUT2_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_lut2.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_TMEDIAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_xmedian.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_TMIDEQUALIZER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_tmidequalizer.c
	)
endif()

if ( FFMPEG_CONFIG_TMIX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_mix.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_TONEMAP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_tonemap.c
	)
endif()

if ( FFMPEG_CONFIG_TONEMAP_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_tonemap_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/tonemap.c
		${AV_DIR}opencl/colorspace_common.c
	)
endif()

if ( FFMPEG_CONFIG_TONEMAP_VAAPI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_tonemap_vaapi.c
		${AV_DIR}vaapi_vpp.c
	)
endif()

if ( FFMPEG_CONFIG_TPAD_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_tpad.c
	)
endif()

if ( FFMPEG_CONFIG_TRANSPOSE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_transpose.c
	)
endif()

if ( FFMPEG_CONFIG_TRANSPOSE_NPP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_transpose_npp.c
	)
endif()

if ( FFMPEG_CONFIG_TRANSPOSE_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_transpose_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/transpose.c
	)
endif()

if ( FFMPEG_CONFIG_TRANSPOSE_VAAPI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_transpose_vaapi.c
		${AV_DIR}vaapi_vpp.c
	)
endif()

if ( FFMPEG_CONFIG_TRANSPOSE_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_transpose_vulkan.c
		${AV_DIR}vulkan.c
		${AV_DIR}vulkan_filter.c
	)
endif()

if ( FFMPEG_CONFIG_TRIM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}trim.c
	)
endif()

if ( FFMPEG_CONFIG_UNPREMULTIPLY_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_premultiply.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_UNSHARP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_unsharp.c
	)
endif()

if ( FFMPEG_CONFIG_UNSHARP_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_unsharp_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/unsharp.c
	)
endif()

if ( FFMPEG_CONFIG_UNTILE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_untile.c
	)
endif()

if ( FFMPEG_CONFIG_USPP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_uspp.c
		${AV_DIR}qp_table.c
	)
endif()

if ( FFMPEG_CONFIG_V360_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_v360.c
	)
endif()

if ( FFMPEG_CONFIG_VAGUEDENOISER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vaguedenoiser.c
	)
endif()

if ( FFMPEG_CONFIG_VARBLUR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_varblur.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_VECTORSCOPE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vectorscope.c
	)
endif()

if ( FFMPEG_CONFIG_VFLIP_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vflip.c
	)
endif()

if ( FFMPEG_CONFIG_VFLIP_VULKAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_flip_vulkan.c
		${AV_DIR}vulkan.c
	)
endif()

if ( FFMPEG_CONFIG_VFRDET_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vfrdet.c
	)
endif()

if ( FFMPEG_CONFIG_VIBRANCE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vibrance.c
	)
endif()

if ( FFMPEG_CONFIG_VIDSTABDETECT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vidstabutils.c
		${AV_DIR}vf_vidstabdetect.c
	)
endif()

if ( FFMPEG_CONFIG_VIDSTABTRANSFORM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vidstabutils.c
		${AV_DIR}vf_vidstabtransform.c
	)
endif()

if ( FFMPEG_CONFIG_VIF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vif.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_VIGNETTE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vignette.c
	)
endif()

if ( FFMPEG_CONFIG_VMAFMOTION_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vmafmotion.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_VPP_QSV_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_vpp_qsv.c
	)
endif()

if ( FFMPEG_CONFIG_VSTACK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_stack.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_W3FDIF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_w3fdif.c
	)
endif()

if ( FFMPEG_CONFIG_WAVEFORM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_waveform.c
	)
endif()

if ( FFMPEG_CONFIG_WEAVE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_weave.c
	)
endif()

if ( FFMPEG_CONFIG_XBR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_xbr.c
	)
endif()

if ( FFMPEG_CONFIG_XCORRELATE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_convolve.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_XFADE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_xfade.c
	)
endif()

if ( FFMPEG_CONFIG_XFADE_OPENCL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_xfade_opencl.c
		${AV_DIR}opencl.c
		${AV_DIR}opencl/xfade.c
	)
endif()

if ( FFMPEG_CONFIG_XMEDIAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_xmedian.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_XSTACK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_stack.c
		${AV_DIR}framesync.c
	)
endif()

if ( FFMPEG_CONFIG_YADIF_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_yadif.c
		${AV_DIR}yadif_common.c
	)
endif()

if ( FFMPEG_CONFIG_YADIF_CUDA_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_yadif_cuda.c
		${AV_DIR}vf_yadif_cuda.ptx.c
		${AV_DIR}yadif_common.c
		${AV_DIR}cuda/load_helper.c
	)
endif()

if ( FFMPEG_CONFIG_YADIF_VIDEOTOOLBOX_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_yadif_videotoolbox.c
		${AV_DIR}metal/vf_yadif_videotoolbox.metallib.c
		${AV_DIR}metal/utils.c
		${AV_DIR}yadif_common.c
	)
endif()

if ( FFMPEG_CONFIG_YAEPBLUR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_yaepblur.c
	)
endif()

if ( FFMPEG_CONFIG_ZMQ_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_zmq.c
	)
endif()

if ( FFMPEG_CONFIG_ZOOMPAN_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_zoompan.c
	)
endif()

if ( FFMPEG_CONFIG_ZSCALE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_zscale.c
	)
endif()


if ( FFMPEG_CONFIG_ALLRGB_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_ALLYUV_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_CELLAUTO_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_cellauto.c
	)
endif()

if ( FFMPEG_CONFIG_COLOR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_COLORCHART_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_COLORSPECTRUM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_COREIMAGESRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_coreimage.c
	)
endif()

if ( FFMPEG_CONFIG_FREI0R_SRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_frei0r.c
	)
endif()

if ( FFMPEG_CONFIG_GRADIENTS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_gradients.c
	)
endif()

if ( FFMPEG_CONFIG_HALDCLUTSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_LIFE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_life.c
	)
endif()

if ( FFMPEG_CONFIG_MANDELBROT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_mandelbrot.c
	)
endif()

if ( FFMPEG_CONFIG_MPTESTSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_mptestsrc.c
	)
endif()

if ( FFMPEG_CONFIG_NULLSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_OPENCLSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vf_program_opencl.c
		${AV_DIR}opencl.c
	)
endif()

if ( FFMPEG_CONFIG_PAL75BARS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_PAL100BARS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_RGBTESTSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_SIERPINSKI_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_sierpinski.c
	)
endif()

if ( FFMPEG_CONFIG_SMPTEBARS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_SMPTEHDBARS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_TESTSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_TESTSRC2_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()

if ( FFMPEG_CONFIG_YUVTESTSRC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsrc_testsrc.c
	)
endif()


if ( FFMPEG_CONFIG_NULLSINK_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vsink_nullsink.c
	)
endif()


# multimedia filters
if ( FFMPEG_CONFIG_ABITSCOPE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_abitscope.c
	)
endif()

if ( FFMPEG_CONFIG_ADRAWGRAPH_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_drawgraph.c
	)
endif()

if ( FFMPEG_CONFIG_AGRAPHMONITOR_FILTER )
	list(APPEND device_srcs
		${AV_DIR}f_graphmonitor.c
	)
endif()

if ( FFMPEG_CONFIG_AHISTOGRAM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_ahistogram.c
	)
endif()

if ( FFMPEG_CONFIG_APHASEMETER_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_aphasemeter.c
	)
endif()

if ( FFMPEG_CONFIG_AVECTORSCOPE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_avectorscope.c
	)
endif()

if ( FFMPEG_CONFIG_CONCAT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_concat.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWCQT_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_showcqt.c
		${AV_DIR}lswsutils.c
		${AV_DIR}lavfutils.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWFREQS_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_showfreqs.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWSPATIAL_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_showspatial.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWSPECTRUM_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_showspectrum.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWSPECTRUMPIC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_showspectrum.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWVOLUME_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_showvolume.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWWAVES_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_showwaves.c
	)
endif()

if ( FFMPEG_CONFIG_SHOWWAVESPIC_FILTER )
	list(APPEND device_srcs
		${AV_DIR}avf_showwaves.c
	)
endif()

if ( FFMPEG_CONFIG_SPECTRUMSYNTH_FILTER )
	list(APPEND device_srcs
		${AV_DIR}vaf_spectrumsynth.c
	)
endif()


# multimedia sources
if ( FFMPEG_CONFIG_AVSYNCTEST_FILTER )
	list(APPEND device_srcs
		${AV_DIR}src_avsynctest.c
	)
endif()

if ( FFMPEG_CONFIG_AMOVIE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}src_movie.c
	)
endif()

if ( FFMPEG_CONFIG_MOVIE_FILTER )
	list(APPEND device_srcs
		${AV_DIR}src_movie.c
	)
endif()

list(REMOVE_DUPLICATES device_srcs)

target_include_directories(libavfilter PRIVATE ${FFMPEG_CONFIG_HEADER_DIR})

IF( device_srcs )
  add_library(libavfilter_aux OBJECT ${device_srcs})
	target_include_directories(libavfilter_aux PRIVATE ${AV_DIR})
  target_include_directories(libavfilter_aux AFTER PRIVATE ${FFMPEG_CONFIG_HEADER_DIR})

	if (FFMPEG_CONFIG_DNN )
		target_include_directories(libavfilter_aux AFTER PRIVATE ${DNN_DIR})
	endif()

  target_link_libraries(libavfilter libavfilter_aux)
ENDIF()

list(APPEND EXTRA_LIBS libavfilter)