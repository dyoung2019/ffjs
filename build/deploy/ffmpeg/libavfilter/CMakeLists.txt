cmake_minimum_required(VERSION 3.22)

message(VAR(libavfilter) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

SET(AV_DIR ${CMAKE_CURRENT_SOURCE_DIR}/ffmpeg/libavfilter/)

add_library(libavfilter STATIC
	allfilters.c
	audio.c
	avfilter.c
	avfiltergraph.c
	buffersink.c
	buffersrc.c
	colorspace.c
	drawutils.c
	fifo.c
	formats.c
	framepool.c
	framequeue.c
	graphdump.c
	graphparser.c
	version.c
	video.c
)

target_include_directories(libavfilter
  INTERFACE ${AV_DIR}
)

target_include_directories(libavfilter
  PRIVATE ${AV_DIR}
)

set(LIBAVFILTER_C_FLAGS 
	-Wno-pointer-sign 
	-Wno-implicit-function-declaration
	-Wno-switch
	-Wno-parentheses
)

target_compile_options(libavfilter PUBLIC -DHAVE_AV_CONFIG_H=1)
target_compile_options(libavfilter INTERFACE ${LIBAVFILTER_C_FLAGS})

target_include_directories(libavfilter 
	INTERFACE ${FFMPEG_INCLUDE_HEADER_DIR}
	PRIVATE ${FFMPEG_INCLUDE_HEADER_DIR}libavutil
)

target_link_directories(libavfilter 
	INTERFACE ${FFMPEG_INCLUDE_HEADER_DIR}
	PRIVATE ${FFMPEG_INCLUDE_HEADER_DIR}libavutil
)


set(device_srcs)

# if (FFMPEG_----- ) 
#   list(APPEND device_srcs
#     ${AV_DIR}avfoundation.c
#   )
# endif()

set(DNN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dnn/)

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

if ( HAVE_LIBC_MSVCRT )
	list(APPEND device_srcs
		file_open.c
	)
endif()

if ( HAVE_THREADS )
	list(APPEND device_srcs
		pthread.c
	)
endif()


# subsystems
if ( CONFIG_QSVVPP )
	list(APPEND device_srcs
		qsvvpp.c
	)
endif()

if ( CONFIG_SCENE_SAD )
	list(APPEND device_srcs
		scene_sad.c
	)
endif()

if ( CONFIG_DNN )
	list(APPEND device_srcs
		dnn_filter_common.c
	)
endif()

# audio filters
if ( CONFIG_ABENCH_FILTER )
	list(APPEND device_srcs
		f_bench.c
	)
endif()

if ( CONFIG_ACOMPRESSOR_FILTER )
	list(APPEND device_srcs
		af_sidechaincompress.c
	)
endif()

if ( CONFIG_ACONTRAST_FILTER )
	list(APPEND device_srcs
		af_acontrast.c
	)
endif()

if ( CONFIG_ACOPY_FILTER )
	list(APPEND device_srcs
		af_acopy.c
	)
endif()

if ( CONFIG_ACROSSFADE_FILTER )
	list(APPEND device_srcs
		af_afade.c
	)
endif()

if ( CONFIG_ACROSSOVER_FILTER )
	list(APPEND device_srcs
		af_acrossover.c
	)
endif()

if ( CONFIG_ACRUSHER_FILTER )
	list(APPEND device_srcs
		af_acrusher.c
	)
endif()

if ( CONFIG_ACUE_FILTER )
	list(APPEND device_srcs
		f_cue.c
	)
endif()

if ( CONFIG_ADECLICK_FILTER )
	list(APPEND device_srcs
		af_adeclick.c
	)
endif()

if ( CONFIG_ADECLIP_FILTER )
	list(APPEND device_srcs
		af_adeclick.c
	)
endif()

if ( CONFIG_ADECORRELATE_FILTER )
	list(APPEND device_srcs
		af_adecorrelate.c
	)
endif()

if ( CONFIG_ADELAY_FILTER )
	list(APPEND device_srcs
		af_adelay.c
	)
endif()

if ( CONFIG_ADENORM_FILTER )
	list(APPEND device_srcs
		af_adenorm.c
	)
endif()

if ( CONFIG_ADERIVATIVE_FILTER )
	list(APPEND device_srcs
		af_aderivative.c
	)
endif()

if ( CONFIG_ADYNAMICEQUALIZER_FILTER )
	list(APPEND device_srcs
		af_adynamicequalizer.c
	)
endif()

if ( CONFIG_ADYNAMICSMOOTH_FILTER )
	list(APPEND device_srcs
		af_adynamicsmooth.c
	)
endif()

if ( CONFIG_AECHO_FILTER )
	list(APPEND device_srcs
		af_aecho.c
	)
endif()

if ( CONFIG_AEMPHASIS_FILTER )
	list(APPEND device_srcs
		af_aemphasis.c
	)
endif()

if ( CONFIG_AEVAL_FILTER )
	list(APPEND device_srcs
		aeval.c
	)
endif()

if ( CONFIG_AEXCITER_FILTER )
	list(APPEND device_srcs
		af_aexciter.c
	)
endif()

if ( CONFIG_AFADE_FILTER )
	list(APPEND device_srcs
		af_afade.c
	)
endif()

if ( CONFIG_AFFTDN_FILTER )
	list(APPEND device_srcs
		af_afftdn.c
	)
endif()

if ( CONFIG_AFFTFILT_FILTER )
	list(APPEND device_srcs
		af_afftfilt.c
	)
endif()

if ( CONFIG_AFIR_FILTER )
	list(APPEND device_srcs
		af_afir.c
	)
endif()

if ( CONFIG_AFORMAT_FILTER )
	list(APPEND device_srcs
		af_aformat.c
	)
endif()

if ( CONFIG_AFREQSHIFT_FILTER )
	list(APPEND device_srcs
		af_afreqshift.c
	)
endif()

if ( CONFIG_AFWTDN_FILTER )
	list(APPEND device_srcs
		af_afwtdn.c
	)
endif()

if ( CONFIG_AGATE_FILTER )
	list(APPEND device_srcs
		af_agate.c
	)
endif()

if ( CONFIG_AIIR_FILTER )
	list(APPEND device_srcs
		af_aiir.c
	)
endif()

if ( CONFIG_AINTEGRAL_FILTER )
	list(APPEND device_srcs
		af_aderivative.c
	)
endif()

if ( CONFIG_AINTERLEAVE_FILTER )
	list(APPEND device_srcs
		f_interleave.c
	)
endif()

if ( CONFIG_ALATENCY_FILTER )
	list(APPEND device_srcs
		f_latency.c
	)
endif()

if ( CONFIG_ALIMITER_FILTER )
	list(APPEND device_srcs
		af_alimiter.c
	)
endif()

if ( CONFIG_ALLPASS_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_ALOOP_FILTER )
	list(APPEND device_srcs
		f_loop.c
	)
endif()

if ( CONFIG_AMERGE_FILTER )
	list(APPEND device_srcs
		af_amerge.c
	)
endif()

if ( CONFIG_AMETADATA_FILTER )
	list(APPEND device_srcs
		f_metadata.c
	)
endif()

if ( CONFIG_AMIX_FILTER )
	list(APPEND device_srcs
		af_amix.c
	)
endif()

if ( CONFIG_AMULTIPLY_FILTER )
	list(APPEND device_srcs
		af_amultiply.c
	)
endif()

if ( CONFIG_ANEQUALIZER_FILTER )
	list(APPEND device_srcs
		af_anequalizer.c
	)
endif()

if ( CONFIG_ANLMDN_FILTER )
	list(APPEND device_srcs
		af_anlmdn.c
	)
endif()

if ( CONFIG_ANLMF_FILTER )
	list(APPEND device_srcs
		af_anlms.c
	)
endif()

if ( CONFIG_ANLMS_FILTER )
	list(APPEND device_srcs
		af_anlms.c
	)
endif()

if ( CONFIG_ANULL_FILTER )
	list(APPEND device_srcs
		af_anull.c
	)
endif()

if ( CONFIG_APAD_FILTER )
	list(APPEND device_srcs
		af_apad.c
	)
endif()

if ( CONFIG_APERMS_FILTER )
	list(APPEND device_srcs
		f_perms.c
	)
endif()

if ( CONFIG_APHASER_FILTER )
	list(APPEND device_srcs
		af_aphaser.c
		generate_wave_table.c
	)
endif()

if ( CONFIG_APHASESHIFT_FILTER )
	list(APPEND device_srcs
		af_afreqshift.c
	)
endif()

if ( CONFIG_APSYCLIP_FILTER )
	list(APPEND device_srcs
		af_apsyclip.c
	)
endif()

if ( CONFIG_APULSATOR_FILTER )
	list(APPEND device_srcs
		af_apulsator.c
	)
endif()

if ( CONFIG_AREALTIME_FILTER )
	list(APPEND device_srcs
		f_realtime.c
	)
endif()

if ( CONFIG_ARESAMPLE_FILTER )
	list(APPEND device_srcs
		af_aresample.c
	)
endif()

if ( CONFIG_AREVERSE_FILTER )
	list(APPEND device_srcs
		f_reverse.c
	)
endif()

if ( CONFIG_ARNNDN_FILTER )
	list(APPEND device_srcs
		af_arnndn.c
	)
endif()

if ( CONFIG_ASDR_FILTER )
	list(APPEND device_srcs
		af_asdr.c
	)
endif()

if ( CONFIG_ASEGMENT_FILTER )
	list(APPEND device_srcs
		f_segment.c
	)
endif()

if ( CONFIG_ASELECT_FILTER )
	list(APPEND device_srcs
		f_select.c
	)
endif()

if ( CONFIG_ASENDCMD_FILTER )
	list(APPEND device_srcs
		f_sendcmd.c
	)
endif()

if ( CONFIG_ASETNSAMPLES_FILTER )
	list(APPEND device_srcs
		af_asetnsamples.c
	)
endif()

if ( CONFIG_ASETPTS_FILTER )
	list(APPEND device_srcs
		setpts.c
	)
endif()

if ( CONFIG_ASETRATE_FILTER )
	list(APPEND device_srcs
		af_asetrate.c
	)
endif()

if ( CONFIG_ASETTB_FILTER )
	list(APPEND device_srcs
		settb.c
	)
endif()

if ( CONFIG_ASHOWINFO_FILTER )
	list(APPEND device_srcs
		af_ashowinfo.c
	)
endif()

if ( CONFIG_ASIDEDATA_FILTER )
	list(APPEND device_srcs
		f_sidedata.c
	)
endif()

if ( CONFIG_ASOFTCLIP_FILTER )
	list(APPEND device_srcs
		af_asoftclip.c
	)
endif()

if ( CONFIG_ASPECTRALSTATS_FILTER )
	list(APPEND device_srcs
		af_aspectralstats.c
	)
endif()

if ( CONFIG_ASPLIT_FILTER )
	list(APPEND device_srcs
		split.c
	)
endif()

if ( CONFIG_ASR_FILTER )
	list(APPEND device_srcs
		af_asr.c
	)
endif()

if ( CONFIG_ASTATS_FILTER )
	list(APPEND device_srcs
		af_astats.c
	)
endif()

if ( CONFIG_ASTREAMSELECT_FILTER )
	list(APPEND device_srcs
		f_streamselect.c
		framesync.c
	)
endif()

if ( CONFIG_ASUBBOOST_FILTER )
	list(APPEND device_srcs
		af_asubboost.c
	)
endif()

if ( CONFIG_ASUBCUT_FILTER )
	list(APPEND device_srcs
		af_asupercut.c
	)
endif()

if ( CONFIG_ASUPERCUT_FILTER )
	list(APPEND device_srcs
		af_asupercut.c
	)
endif()

if ( CONFIG_ASUPERPASS_FILTER )
	list(APPEND device_srcs
		af_asupercut.c
	)
endif()

if ( CONFIG_ASUPERSTOP_FILTER )
	list(APPEND device_srcs
		af_asupercut.c
	)
endif()

if ( CONFIG_ATEMPO_FILTER )
	list(APPEND device_srcs
		af_atempo.c
	)
endif()

if ( CONFIG_ATILT_FILTER )
	list(APPEND device_srcs
		af_atilt.c
	)
endif()

if ( CONFIG_ATRIM_FILTER )
	list(APPEND device_srcs
		trim.c
	)
endif()

if ( CONFIG_AXCORRELATE_FILTER )
	list(APPEND device_srcs
		af_axcorrelate.c
	)
endif()

if ( CONFIG_AZMQ_FILTER )
	list(APPEND device_srcs
		f_zmq.c
	)
endif()

if ( CONFIG_BANDPASS_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_BANDREJECT_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_BASS_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_BIQUAD_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_BS2B_FILTER )
	list(APPEND device_srcs
		af_bs2b.c
	)
endif()

if ( CONFIG_CHANNELMAP_FILTER )
	list(APPEND device_srcs
		af_channelmap.c
	)
endif()

if ( CONFIG_CHANNELSPLIT_FILTER )
	list(APPEND device_srcs
		af_channelsplit.c
	)
endif()

if ( CONFIG_CHORUS_FILTER )
	list(APPEND device_srcs
		af_chorus.c
		generate_wave_table.c
	)
endif()

if ( CONFIG_COMPAND_FILTER )
	list(APPEND device_srcs
		af_compand.c
	)
endif()

if ( CONFIG_COMPENSATIONDELAY_FILTER )
	list(APPEND device_srcs
		af_compensationdelay.c
	)
endif()

if ( CONFIG_CROSSFEED_FILTER )
	list(APPEND device_srcs
		af_crossfeed.c
	)
endif()

if ( CONFIG_CRYSTALIZER_FILTER )
	list(APPEND device_srcs
		af_crystalizer.c
	)
endif()

if ( CONFIG_DCSHIFT_FILTER )
	list(APPEND device_srcs
		af_dcshift.c
	)
endif()

if ( CONFIG_DEESSER_FILTER )
	list(APPEND device_srcs
		af_deesser.c
	)
endif()

if ( CONFIG_DIALOGUENHANCE_FILTER )
	list(APPEND device_srcs
		af_dialoguenhance.c
	)
endif()

if ( CONFIG_DRMETER_FILTER )
	list(APPEND device_srcs
		af_drmeter.c
	)
endif()

if ( CONFIG_DYNAUDNORM_FILTER )
	list(APPEND device_srcs
		af_dynaudnorm.c
	)
endif()

if ( CONFIG_EARWAX_FILTER )
	list(APPEND device_srcs
		af_earwax.c
	)
endif()

if ( CONFIG_EBUR128_FILTER )
	list(APPEND device_srcs
		f_ebur128.c
	)
endif()

if ( CONFIG_EQUALIZER_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_EXTRASTEREO_FILTER )
	list(APPEND device_srcs
		af_extrastereo.c
	)
endif()

if ( CONFIG_FIREQUALIZER_FILTER )
	list(APPEND device_srcs
		af_firequalizer.c
	)
endif()

if ( CONFIG_FLANGER_FILTER )
	list(APPEND device_srcs
		af_flanger.c
		generate_wave_table.c
	)
endif()

if ( CONFIG_HAAS_FILTER )
	list(APPEND device_srcs
		af_haas.c
	)
endif()

if ( CONFIG_HDCD_FILTER )
	list(APPEND device_srcs
		af_hdcd.c
	)
endif()

if ( CONFIG_HEADPHONE_FILTER )
	list(APPEND device_srcs
		af_headphone.c
	)
endif()

if ( CONFIG_HIGHPASS_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_HIGHSHELF_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_JOIN_FILTER )
	list(APPEND device_srcs
		af_join.c
	)
endif()

if ( CONFIG_LADSPA_FILTER )
	list(APPEND device_srcs
		af_ladspa.c
	)
endif()

if ( CONFIG_LOUDNORM_FILTER )
	list(APPEND device_srcs
		af_loudnorm.c
		ebur128.c
	)
endif()

if ( CONFIG_LOWPASS_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_LOWSHELF_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_LV2_FILTER )
	list(APPEND device_srcs
		af_lv2.c
	)
endif()

if ( CONFIG_MCOMPAND_FILTER )
	list(APPEND device_srcs
		af_mcompand.c
	)
endif()

if ( CONFIG_PAN_FILTER )
	list(APPEND device_srcs
		af_pan.c
	)
endif()

if ( CONFIG_REPLAYGAIN_FILTER )
	list(APPEND device_srcs
		af_replaygain.c
	)
endif()

if ( CONFIG_RUBBERBAND_FILTER )
	list(APPEND device_srcs
		af_rubberband.c
	)
endif()

if ( CONFIG_SIDECHAINCOMPRESS_FILTER )
	list(APPEND device_srcs
		af_sidechaincompress.c
	)
endif()

if ( CONFIG_SIDECHAINGATE_FILTER )
	list(APPEND device_srcs
		af_agate.c
	)
endif()

if ( CONFIG_SILENCEDETECT_FILTER )
	list(APPEND device_srcs
		af_silencedetect.c
	)
endif()

if ( CONFIG_SILENCEREMOVE_FILTER )
	list(APPEND device_srcs
		af_silenceremove.c
	)
endif()

if ( CONFIG_SOFALIZER_FILTER )
	list(APPEND device_srcs
		af_sofalizer.c
	)
endif()

if ( CONFIG_SPEECHNORM_FILTER )
	list(APPEND device_srcs
		af_speechnorm.c
	)
endif()

if ( CONFIG_STEREOTOOLS_FILTER )
	list(APPEND device_srcs
		af_stereotools.c
	)
endif()

if ( CONFIG_STEREOWIDEN_FILTER )
	list(APPEND device_srcs
		af_stereowiden.c
	)
endif()

if ( CONFIG_SUPEREQUALIZER_FILTER )
	list(APPEND device_srcs
		af_superequalizer.c
	)
endif()

if ( CONFIG_SURROUND_FILTER )
	list(APPEND device_srcs
		af_surround.c
	)
endif()

if ( CONFIG_TREBLE_FILTER )
	list(APPEND device_srcs
		af_biquads.c
	)
endif()

if ( CONFIG_TREMOLO_FILTER )
	list(APPEND device_srcs
		af_tremolo.c
	)
endif()

if ( CONFIG_VIBRATO_FILTER )
	list(APPEND device_srcs
		af_vibrato.c
		generate_wave_table.c
	)
endif()

if ( CONFIG_VIRTUALBASS_FILTER )
	list(APPEND device_srcs
		af_virtualbass.c
	)
endif()

if ( CONFIG_VOLUME_FILTER )
	list(APPEND device_srcs
		af_volume.c
	)
endif()

if ( CONFIG_VOLUMEDETECT_FILTER )
	list(APPEND device_srcs
		af_volumedetect.c
	)
endif()


if ( CONFIG_AEVALSRC_FILTER )
	list(APPEND device_srcs
		aeval.c
	)
endif()

if ( CONFIG_AFIRSRC_FILTER )
	list(APPEND device_srcs
		asrc_afirsrc.c
	)
endif()

if ( CONFIG_ANOISESRC_FILTER )
	list(APPEND device_srcs
		asrc_anoisesrc.c
	)
endif()

if ( CONFIG_ANULLSRC_FILTER )
	list(APPEND device_srcs
		asrc_anullsrc.c
	)
endif()

if ( CONFIG_FLITE_FILTER )
	list(APPEND device_srcs
		asrc_flite.c
	)
endif()

if ( CONFIG_HILBERT_FILTER )
	list(APPEND device_srcs
		asrc_hilbert.c
	)
endif()

if ( CONFIG_SINC_FILTER )
	list(APPEND device_srcs
		asrc_sinc.c
	)
endif()

if ( CONFIG_SINE_FILTER )
	list(APPEND device_srcs
		asrc_sine.c
	)
endif()


if ( CONFIG_ANULLSINK_FILTER )
	list(APPEND device_srcs
		asink_anullsink.c
	)
endif()


# video filters
if ( CONFIG_ADDROI_FILTER )
	list(APPEND device_srcs
		vf_addroi.c
	)
endif()

if ( CONFIG_ALPHAEXTRACT_FILTER )
	list(APPEND device_srcs
		vf_extractplanes.c
	)
endif()

if ( CONFIG_ALPHAMERGE_FILTER )
	list(APPEND device_srcs
		vf_alphamerge.c
		framesync.c
	)
endif()

if ( CONFIG_AMPLIFY_FILTER )
	list(APPEND device_srcs
		vf_amplify.c
	)
endif()

if ( CONFIG_ASS_FILTER )
	list(APPEND device_srcs
		vf_subtitles.c
	)
endif()

if ( CONFIG_ATADENOISE_FILTER )
	list(APPEND device_srcs
		vf_atadenoise.c
	)
endif()

if ( CONFIG_AVGBLUR_FILTER )
	list(APPEND device_srcs
		vf_avgblur.c
	)
endif()

if ( CONFIG_AVGBLUR_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_avgblur_opencl.c
		opencl.c
		opencl/avgblur.c
		boxblur.c
	)
endif()

if ( CONFIG_AVGBLUR_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_avgblur_vulkan.c
		vulkan.c
		vulkan_filter.c
	)
endif()

if ( CONFIG_BBOX_FILTER )
	list(APPEND device_srcs
		bbox.c
		vf_bbox.c
	)
endif()

if ( CONFIG_BENCH_FILTER )
	list(APPEND device_srcs
		f_bench.c
	)
endif()

if ( CONFIG_BILATERAL_FILTER )
	list(APPEND device_srcs
		vf_bilateral.c
	)
endif()

if ( CONFIG_BITPLANENOISE_FILTER )
	list(APPEND device_srcs
		vf_bitplanenoise.c
	)
endif()

if ( CONFIG_BLACKDETECT_FILTER )
	list(APPEND device_srcs
		vf_blackdetect.c
	)
endif()

if ( CONFIG_BLACKFRAME_FILTER )
	list(APPEND device_srcs
		vf_blackframe.c
	)
endif()

if ( CONFIG_BLEND_FILTER )
	list(APPEND device_srcs
		vf_blend.c
		framesync.c
	)
endif()

if ( CONFIG_BLEND_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_blend_vulkan.c
		framesync.c
		vulkan.c
		vulkan_filter.c
	)
endif()

if ( CONFIG_BLOCKDETECT_FILTER )
	list(APPEND device_srcs
		vf_blockdetect.c
	)
endif()

if ( CONFIG_BLURDETECT_FILTER )
	list(APPEND device_srcs
		vf_blurdetect.c
		edge_common.c
	)
endif()

if ( CONFIG_BM3D_FILTER )
	list(APPEND device_srcs
		vf_bm3d.c
		framesync.c
	)
endif()

if ( CONFIG_BOXBLUR_FILTER )
	list(APPEND device_srcs
		vf_boxblur.c
		boxblur.c
	)
endif()

if ( CONFIG_BOXBLUR_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_avgblur_opencl.c
		opencl.c
		opencl/avgblur.c
		boxblur.c
	)
endif()

if ( CONFIG_BWDIF_FILTER )
	list(APPEND device_srcs
		vf_bwdif.c
		yadif_common.c
	)
endif()

if ( CONFIG_CAS_FILTER )
	list(APPEND device_srcs
		vf_cas.c
	)
endif()

if ( CONFIG_CHROMABER_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_chromaber_vulkan.c
		vulkan.c
		vulkan_filter.c
	)
endif()

if ( CONFIG_CHROMAHOLD_FILTER )
	list(APPEND device_srcs
		vf_chromakey.c
	)
endif()

if ( CONFIG_CHROMAKEY_FILTER )
	list(APPEND device_srcs
		vf_chromakey.c
	)
endif()

if ( CONFIG_CHROMAKEY_CUDA_FILTER )
	list(APPEND device_srcs
		vf_chromakey_cuda.c
		vf_chromakey_cuda.ptx.c
	)
endif()


if ( CONFIG_CHROMANR_FILTER )
	list(APPEND device_srcs
		vf_chromanr.c
	)
endif()

if ( CONFIG_CHROMASHIFT_FILTER )
	list(APPEND device_srcs
		vf_chromashift.c
	)
endif()

if ( CONFIG_CIESCOPE_FILTER )
	list(APPEND device_srcs
		vf_ciescope.c
	)
endif()

if ( CONFIG_CODECVIEW_FILTER )
	list(APPEND device_srcs
		vf_codecview.c
		qp_table.c
	)
endif()

if ( CONFIG_COLORBALANCE_FILTER )
	list(APPEND device_srcs
		vf_colorbalance.c
	)
endif()

if ( CONFIG_COLORCHANNELMIXER_FILTER )
	list(APPEND device_srcs
		vf_colorchannelmixer.c
	)
endif()

if ( CONFIG_COLORCONTRAST_FILTER )
	list(APPEND device_srcs
		vf_colorcontrast.c
	)
endif()

if ( CONFIG_COLORCORRECT_FILTER )
	list(APPEND device_srcs
		vf_colorcorrect.c
	)
endif()

if ( CONFIG_COLORIZE_FILTER )
	list(APPEND device_srcs
		vf_colorize.c
	)
endif()

if ( CONFIG_COLORKEY_FILTER )
	list(APPEND device_srcs
		vf_colorkey.c
	)
endif()

if ( CONFIG_COLORKEY_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_colorkey_opencl.c
		opencl.c
		opencl/colorkey.c
	)
endif()

if ( CONFIG_COLORHOLD_FILTER )
	list(APPEND device_srcs
		vf_colorkey.c
	)
endif()

if ( CONFIG_COLORLEVELS_FILTER )
	list(APPEND device_srcs
		vf_colorlevels.c
	)
endif()

if ( CONFIG_COLORMAP_FILTER )
	list(APPEND device_srcs
		vf_colormap.c
	)
endif()

if ( CONFIG_COLORMATRIX_FILTER )
	list(APPEND device_srcs
		vf_colormatrix.c
	)
endif()

if ( CONFIG_COLORSPACE_FILTER )
	list(APPEND device_srcs
		vf_colorspace.c
		colorspacedsp.c
	)
endif()

if ( CONFIG_COLORTEMPERATURE_FILTER )
	list(APPEND device_srcs
		vf_colortemperature.c
	)
endif()

if ( CONFIG_CONVOLUTION_FILTER )
	list(APPEND device_srcs
		vf_convolution.c
	)
endif()

if ( CONFIG_CONVOLUTION_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_convolution_opencl.c
		opencl.c
		opencl/convolution.c
	)
endif()

if ( CONFIG_CONVOLVE_FILTER )
	list(APPEND device_srcs
		vf_convolve.c
		framesync.c
	)
endif()

if ( CONFIG_COPY_FILTER )
	list(APPEND device_srcs
		vf_copy.c
	)
endif()

if ( CONFIG_COREIMAGE_FILTER )
	list(APPEND device_srcs
		vf_coreimage.c
	)
endif()

if ( CONFIG_COVER_RECT_FILTER )
	list(APPEND device_srcs
		vf_cover_rect.c
		lavfutils.c
	)
endif()

if ( CONFIG_CROP_FILTER )
	list(APPEND device_srcs
		vf_crop.c
	)
endif()

if ( CONFIG_CROPDETECT_FILTER )
	list(APPEND device_srcs
		vf_cropdetect.c
	)
endif()

if ( CONFIG_CUE_FILTER )
	list(APPEND device_srcs
		f_cue.c
	)
endif()

if ( CONFIG_CURVES_FILTER )
	list(APPEND device_srcs
		vf_curves.c
	)
endif()

if ( CONFIG_DATASCOPE_FILTER )
	list(APPEND device_srcs
		vf_datascope.c
	)
endif()

if ( CONFIG_DBLUR_FILTER )
	list(APPEND device_srcs
		vf_dblur.c
	)
endif()

if ( CONFIG_DCTDNOIZ_FILTER )
	list(APPEND device_srcs
		vf_dctdnoiz.c
	)
endif()

if ( CONFIG_DEBAND_FILTER )
	list(APPEND device_srcs
		vf_deband.c
	)
endif()

if ( CONFIG_DEBLOCK_FILTER )
	list(APPEND device_srcs
		vf_deblock.c
	)
endif()

if ( CONFIG_DECIMATE_FILTER )
	list(APPEND device_srcs
		vf_decimate.c
	)
endif()

if ( CONFIG_DERAIN_FILTER )
	list(APPEND device_srcs
		vf_derain.c
	)
endif()

if ( CONFIG_DECONVOLVE_FILTER )
	list(APPEND device_srcs
		vf_convolve.c
		framesync.c
	)
endif()

if ( CONFIG_DEDOT_FILTER )
	list(APPEND device_srcs
		vf_dedot.c
	)
endif()

if ( CONFIG_DEFLATE_FILTER )
	list(APPEND device_srcs
		vf_neighbor.c
	)
endif()

if ( CONFIG_DEFLICKER_FILTER )
	list(APPEND device_srcs
		vf_deflicker.c
	)
endif()

if ( CONFIG_DEINTERLACE_QSV_FILTER )
	list(APPEND device_srcs
		vf_deinterlace_qsv.c
	)
endif()

if ( CONFIG_DEINTERLACE_VAAPI_FILTER )
	list(APPEND device_srcs
		vf_deinterlace_vaapi.c
		vaapi_vpp.c
	)
endif()

if ( CONFIG_DEJUDDER_FILTER )
	list(APPEND device_srcs
		vf_dejudder.c
	)
endif()

if ( CONFIG_DELOGO_FILTER )
	list(APPEND device_srcs
		vf_delogo.c
	)
endif()

if ( CONFIG_DENOISE_VAAPI_FILTER )
	list(APPEND device_srcs
		vf_misc_vaapi.c
		vaapi_vpp.c
	)
endif()

if ( CONFIG_DESHAKE_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_deshake_opencl.c
		opencl.c
		opencl/deshake.c
		transform.c
	)
endif()

if ( CONFIG_DESHAKE_FILTER )
	list(APPEND device_srcs
		vf_deshake.c
		transform.c
	)
endif()

if ( CONFIG_DESPILL_FILTER )
	list(APPEND device_srcs
		vf_despill.c
	)
endif()

if ( CONFIG_DETELECINE_FILTER )
	list(APPEND device_srcs
		vf_detelecine.c
	)
endif()

if ( CONFIG_DILATION_FILTER )
	list(APPEND device_srcs
		vf_neighbor.c
	)
endif()

if ( CONFIG_DILATION_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_neighbor_opencl.c
		opencl.c
		opencl/neighbor.c
	)
endif()

if ( CONFIG_DISPLACE_FILTER )
	list(APPEND device_srcs
		vf_displace.c
		framesync.c
	)
endif()

if ( CONFIG_DNN_CLASSIFY_FILTER )
	list(APPEND device_srcs
		vf_dnn_classify.c
	)
endif()

if ( CONFIG_DNN_DETECT_FILTER )
	list(APPEND device_srcs
		vf_dnn_detect.c
	)
endif()

if ( CONFIG_DNN_PROCESSING_FILTER )
	list(APPEND device_srcs
		vf_dnn_processing.c
	)
endif()

if ( CONFIG_DOUBLEWEAVE_FILTER )
	list(APPEND device_srcs
		vf_weave.c
	)
endif()

if ( CONFIG_DRAWBOX_FILTER )
	list(APPEND device_srcs
		vf_drawbox.c
	)
endif()

if ( CONFIG_DRAWGRAPH_FILTER )
	list(APPEND device_srcs
		f_drawgraph.c
	)
endif()

if ( CONFIG_DRAWGRID_FILTER )
	list(APPEND device_srcs
		vf_drawbox.c
	)
endif()

if ( CONFIG_DRAWTEXT_FILTER )
	list(APPEND device_srcs
		vf_drawtext.c
	)
endif()

if ( CONFIG_EDGEDETECT_FILTER )
	list(APPEND device_srcs
		vf_edgedetect.c
		edge_common.c
	)
endif()

if ( CONFIG_ELBG_FILTER )
	list(APPEND device_srcs
		vf_elbg.c
	)
endif()

if ( CONFIG_ENTROPY_FILTER )
	list(APPEND device_srcs
		vf_entropy.c
	)
endif()

if ( CONFIG_EPX_FILTER )
	list(APPEND device_srcs
		vf_epx.c
	)
endif()

if ( CONFIG_EQ_FILTER )
	list(APPEND device_srcs
		vf_eq.c
	)
endif()

if ( CONFIG_EROSION_FILTER )
	list(APPEND device_srcs
		vf_neighbor.c
	)
endif()

if ( CONFIG_EROSION_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_neighbor_opencl.c
		opencl.c
		opencl/neighbor.c
	)
endif()

if ( CONFIG_ESTDIF_FILTER )
	list(APPEND device_srcs
		vf_estdif.c
	)
endif()

if ( CONFIG_EXPOSURE_FILTER )
	list(APPEND device_srcs
		vf_exposure.c
	)
endif()

if ( CONFIG_EXTRACTPLANES_FILTER )
	list(APPEND device_srcs
		vf_extractplanes.c
	)
endif()

if ( CONFIG_FADE_FILTER )
	list(APPEND device_srcs
		vf_fade.c
	)
endif()

if ( CONFIG_FEEDBACK_FILTER )
	list(APPEND device_srcs
		vf_feedback.c
	)
endif()

if ( CONFIG_FFTDNOIZ_FILTER )
	list(APPEND device_srcs
		vf_fftdnoiz.c
	)
endif()

if ( CONFIG_FFTFILT_FILTER )
	list(APPEND device_srcs
		vf_fftfilt.c
	)
endif()

if ( CONFIG_FIELD_FILTER )
	list(APPEND device_srcs
		vf_field.c
	)
endif()

if ( CONFIG_FIELDHINT_FILTER )
	list(APPEND device_srcs
		vf_fieldhint.c
	)
endif()

if ( CONFIG_FIELDMATCH_FILTER )
	list(APPEND device_srcs
		vf_fieldmatch.c
	)
endif()

if ( CONFIG_FIELDORDER_FILTER )
	list(APPEND device_srcs
		vf_fieldorder.c
	)
endif()

if ( CONFIG_FILLBORDERS_FILTER )
	list(APPEND device_srcs
		vf_fillborders.c
	)
endif()

if ( CONFIG_FIND_RECT_FILTER )
	list(APPEND device_srcs
		vf_find_rect.c
		lavfutils.c
	)
endif()

if ( CONFIG_FLOODFILL_FILTER )
	list(APPEND device_srcs
		vf_floodfill.c
	)
endif()

if ( CONFIG_FORMAT_FILTER )
	list(APPEND device_srcs
		vf_format.c
	)
endif()

if ( CONFIG_FPS_FILTER )
	list(APPEND device_srcs
		vf_fps.c
	)
endif()

if ( CONFIG_FRAMEPACK_FILTER )
	list(APPEND device_srcs
		vf_framepack.c
	)
endif()

if ( CONFIG_FRAMERATE_FILTER )
	list(APPEND device_srcs
		vf_framerate.c
	)
endif()

if ( CONFIG_FRAMESTEP_FILTER )
	list(APPEND device_srcs
		vf_framestep.c
	)
endif()

if ( CONFIG_FREEZEDETECT_FILTER )
	list(APPEND device_srcs
		vf_freezedetect.c
	)
endif()

if ( CONFIG_FREEZEFRAMES_FILTER )
	list(APPEND device_srcs
		vf_freezeframes.c
	)
endif()

if ( CONFIG_FREI0R_FILTER )
	list(APPEND device_srcs
		vf_frei0r.c
	)
endif()

if ( CONFIG_FSPP_FILTER )
	list(APPEND device_srcs
		vf_fspp.c
		qp_table.c
	)
endif()

if ( CONFIG_GBLUR_FILTER )
	list(APPEND device_srcs
		vf_gblur.c
	)
endif()

if ( CONFIG_GBLUR_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_gblur_vulkan.c
		vulkan.c
		vulkan_filter.c
	)
endif()

if ( CONFIG_GEQ_FILTER )
	list(APPEND device_srcs
		vf_geq.c
	)
endif()

if ( CONFIG_GRADFUN_FILTER )
	list(APPEND device_srcs
		vf_gradfun.c
	)
endif()

if ( CONFIG_GRAPHMONITOR_FILTER )
	list(APPEND device_srcs
		f_graphmonitor.c
	)
endif()

if ( CONFIG_GRAYWORLD_FILTER )
	list(APPEND device_srcs
		vf_grayworld.c
	)
endif()

if ( CONFIG_GREYEDGE_FILTER )
	list(APPEND device_srcs
		vf_colorconstancy.c
	)
endif()

if ( CONFIG_GUIDED_FILTER )
	list(APPEND device_srcs
		vf_guided.c
	)
endif()

if ( CONFIG_HALDCLUT_FILTER )
	list(APPEND device_srcs
		vf_lut3d.c
		framesync.c
	)
endif()

if ( CONFIG_HFLIP_FILTER )
	list(APPEND device_srcs
		vf_hflip.c
	)
endif()

if ( CONFIG_HFLIP_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_flip_vulkan.c
		vulkan.c
	)
endif()

if ( CONFIG_HISTEQ_FILTER )
	list(APPEND device_srcs
		vf_histeq.c
	)
endif()

if ( CONFIG_HISTOGRAM_FILTER )
	list(APPEND device_srcs
		vf_histogram.c
	)
endif()

if ( CONFIG_HQDN3D_FILTER )
	list(APPEND device_srcs
		vf_hqdn3d.c
	)
endif()

if ( CONFIG_HQX_FILTER )
	list(APPEND device_srcs
		vf_hqx.c
	)
endif()

if ( CONFIG_HSTACK_FILTER )
	list(APPEND device_srcs
		vf_stack.c
		framesync.c
	)
endif()

if ( CONFIG_HSVHOLD_FILTER )
	list(APPEND device_srcs
		vf_hsvkey.c
	)
endif()

if ( CONFIG_HSVKEY_FILTER )
	list(APPEND device_srcs
		vf_hsvkey.c
	)
endif()

if ( CONFIG_HUE_FILTER )
	list(APPEND device_srcs
		vf_hue.c
	)
endif()

if ( CONFIG_HUESATURATION_FILTER )
	list(APPEND device_srcs
		vf_huesaturation.c
	)
endif()

if ( CONFIG_HWDOWNLOAD_FILTER )
	list(APPEND device_srcs
		vf_hwdownload.c
	)
endif()

if ( CONFIG_HWMAP_FILTER )
	list(APPEND device_srcs
		vf_hwmap.c
	)
endif()

if ( CONFIG_HWUPLOAD_CUDA_FILTER )
	list(APPEND device_srcs
		vf_hwupload_cuda.c
	)
endif()

if ( CONFIG_HWUPLOAD_FILTER )
	list(APPEND device_srcs
		vf_hwupload.c
	)
endif()

if ( CONFIG_HYSTERESIS_FILTER )
	list(APPEND device_srcs
		vf_hysteresis.c
		framesync.c
	)
endif()

if ( CONFIG_ICCDETECT_FILTER )
	list(APPEND device_srcs
		vf_iccdetect.c
		fflcms2.c
	)
endif()

if ( CONFIG_ICCGEN_FILTER )
	list(APPEND device_srcs
		vf_iccgen.c
		fflcms2.c
	)
endif()

if ( CONFIG_IDENTITY_FILTER )
	list(APPEND device_srcs
		vf_identity.c
	)
endif()

if ( CONFIG_IDET_FILTER )
	list(APPEND device_srcs
		vf_idet.c
	)
endif()

if ( CONFIG_IL_FILTER )
	list(APPEND device_srcs
		vf_il.c
	)
endif()

if ( CONFIG_INFLATE_FILTER )
	list(APPEND device_srcs
		vf_neighbor.c
	)
endif()

if ( CONFIG_INTERLACE_FILTER )
	list(APPEND device_srcs
		vf_tinterlace.c
	)
endif()

if ( CONFIG_INTERLEAVE_FILTER )
	list(APPEND device_srcs
		f_interleave.c
	)
endif()

if ( CONFIG_KERNDEINT_FILTER )
	list(APPEND device_srcs
		vf_kerndeint.c
	)
endif()

if ( CONFIG_KIRSCH_FILTER )
	list(APPEND device_srcs
		vf_convolution.c
	)
endif()

if ( CONFIG_LAGFUN_FILTER )
	list(APPEND device_srcs
		vf_lagfun.c
	)
endif()

if ( CONFIG_LATENCY_FILTER )
	list(APPEND device_srcs
		f_latency.c
	)
endif()

if ( CONFIG_LENSCORRECTION_FILTER )
	list(APPEND device_srcs
		vf_lenscorrection.c
	)
endif()

if ( CONFIG_LENSFUN_FILTER )
	list(APPEND device_srcs
		vf_lensfun.c
	)
endif()

if ( CONFIG_LIBPLACEBO_FILTER )
	list(APPEND device_srcs
		vf_libplacebo.c
		vulkan.c
		vulkan_filter.c
	)
endif()

if ( CONFIG_LIBVMAF_FILTER )
	list(APPEND device_srcs
		vf_libvmaf.c
		framesync.c
	)
endif()

if ( CONFIG_LIMITDIFF_FILTER )
	list(APPEND device_srcs
		vf_limitdiff.c
		framesync.c
	)
endif()

if ( CONFIG_LIMITER_FILTER )
	list(APPEND device_srcs
		vf_limiter.c
	)
endif()

if ( CONFIG_LOOP_FILTER )
	list(APPEND device_srcs
		f_loop.c
	)
endif()

if ( CONFIG_LUMAKEY_FILTER )
	list(APPEND device_srcs
		vf_lumakey.c
	)
endif()

if ( CONFIG_LUT1D_FILTER )
	list(APPEND device_srcs
		vf_lut3d.c
	)
endif()

if ( CONFIG_LUT_FILTER )
	list(APPEND device_srcs
		vf_lut.c
	)
endif()

if ( CONFIG_LUT2_FILTER )
	list(APPEND device_srcs
		vf_lut2.c
		framesync.c
	)
endif()

if ( CONFIG_LUT3D_FILTER )
	list(APPEND device_srcs
		vf_lut3d.c
		framesync.c
	)
endif()

if ( CONFIG_LUTRGB_FILTER )
	list(APPEND device_srcs
		vf_lut.c
	)
endif()

if ( CONFIG_LUTYUV_FILTER )
	list(APPEND device_srcs
		vf_lut.c
	)
endif()

if ( CONFIG_MASKEDCLAMP_FILTER )
	list(APPEND device_srcs
		vf_maskedclamp.c
		framesync.c
	)
endif()

if ( CONFIG_MASKEDMAX_FILTER )
	list(APPEND device_srcs
		vf_maskedminmax.c
		framesync.c
	)
endif()

if ( CONFIG_MASKEDMERGE_FILTER )
	list(APPEND device_srcs
		vf_maskedmerge.c
		framesync.c
	)
endif()

if ( CONFIG_MASKEDMIN_FILTER )
	list(APPEND device_srcs
		vf_maskedminmax.c
		framesync.c
	)
endif()

if ( CONFIG_MASKEDTHRESHOLD_FILTER )
	list(APPEND device_srcs
		vf_maskedthreshold.c
		framesync.c
	)
endif()

if ( CONFIG_MASKFUN_FILTER )
	list(APPEND device_srcs
		vf_maskfun.c
	)
endif()

if ( CONFIG_MCDEINT_FILTER )
	list(APPEND device_srcs
		vf_mcdeint.c
	)
endif()

if ( CONFIG_MEDIAN_FILTER )
	list(APPEND device_srcs
		vf_median.c
	)
endif()

if ( CONFIG_MERGEPLANES_FILTER )
	list(APPEND device_srcs
		vf_mergeplanes.c
		framesync.c
	)
endif()

if ( CONFIG_MESTIMATE_FILTER )
	list(APPEND device_srcs
		vf_mestimate.c
		motion_estimation.c
	)
endif()

if ( CONFIG_METADATA_FILTER )
	list(APPEND device_srcs
		f_metadata.c
	)
endif()

if ( CONFIG_MIDEQUALIZER_FILTER )
	list(APPEND device_srcs
		vf_midequalizer.c
		framesync.c
	)
endif()

if ( CONFIG_MINTERPOLATE_FILTER )
	list(APPEND device_srcs
		vf_minterpolate.c
		motion_estimation.c
	)
endif()

if ( CONFIG_MIX_FILTER )
	list(APPEND device_srcs
		vf_mix.c
		framesync.c
	)
endif()

if ( CONFIG_MONOCHROME_FILTER )
	list(APPEND device_srcs
		vf_monochrome.c
	)
endif()

if ( CONFIG_MORPHO_FILTER )
	list(APPEND device_srcs
		vf_morpho.c
	)
endif()

if ( CONFIG_MPDECIMATE_FILTER )
	list(APPEND device_srcs
		vf_mpdecimate.c
	)
endif()

if ( CONFIG_MULTIPLY_FILTER )
	list(APPEND device_srcs
		vf_multiply.c
	)
endif()

if ( CONFIG_NEGATE_FILTER )
	list(APPEND device_srcs
		vf_negate.c
	)
endif()

if ( CONFIG_NLMEANS_FILTER )
	list(APPEND device_srcs
		vf_nlmeans.c
	)
endif()

if ( CONFIG_NLMEANS_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_nlmeans_opencl.c
		opencl.c
		opencl/nlmeans.c
	)
endif()

if ( CONFIG_NNEDI_FILTER )
	list(APPEND device_srcs
		vf_nnedi.c
	)
endif()

if ( CONFIG_NOFORMAT_FILTER )
	list(APPEND device_srcs
		vf_format.c
	)
endif()

if ( CONFIG_NOISE_FILTER )
	list(APPEND device_srcs
		vf_noise.c
	)
endif()

if ( CONFIG_NORMALIZE_FILTER )
	list(APPEND device_srcs
		vf_normalize.c
	)
endif()

if ( CONFIG_NULL_FILTER )
	list(APPEND device_srcs
		vf_null.c
	)
endif()

if ( CONFIG_OCR_FILTER )
	list(APPEND device_srcs
		vf_ocr.c
	)
endif()

if ( CONFIG_OCV_FILTER )
	list(APPEND device_srcs
		vf_libopencv.c
	)
endif()

if ( CONFIG_OSCILLOSCOPE_FILTER )
	list(APPEND device_srcs
		vf_datascope.c
	)
endif()

if ( CONFIG_OVERLAY_FILTER )
	list(APPEND device_srcs
		vf_overlay.c
		framesync.c
	)
endif()

if ( CONFIG_OVERLAY_CUDA_FILTER )
	list(APPEND device_srcs
		vf_overlay_cuda.c
		framesync.c
		vf_overlay_cuda.ptx.c
		cuda/load_helper.c
	)
endif()

if ( CONFIG_OVERLAY_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_overlay_opencl.c
		opencl.c
		opencl/overlay.c
		framesync.c
	)
endif()

if ( CONFIG_OVERLAY_QSV_FILTER )
	list(APPEND device_srcs
		vf_overlay_qsv.c
		framesync.c
	)
endif()

if ( CONFIG_OVERLAY_VAAPI_FILTER )
	list(APPEND device_srcs
		vf_overlay_vaapi.c
		framesync.c
		vaapi_vpp.c
	)
endif()

if ( CONFIG_OVERLAY_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_overlay_vulkan.c
		vulkan.c
		vulkan_filter.c
	)
endif()

if ( CONFIG_OWDENOISE_FILTER )
	list(APPEND device_srcs
		vf_owdenoise.c
	)
endif()

if ( CONFIG_PAD_FILTER )
	list(APPEND device_srcs
		vf_pad.c
	)
endif()

if ( CONFIG_PAD_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_pad_opencl.c
		opencl.c
		opencl/pad.c
	)
endif()

if ( CONFIG_PALETTEGEN_FILTER )
	list(APPEND device_srcs
		vf_palettegen.c
	)
endif()

if ( CONFIG_PALETTEUSE_FILTER )
	list(APPEND device_srcs
		vf_paletteuse.c
		framesync.c
	)
endif()

if ( CONFIG_PERMS_FILTER )
	list(APPEND device_srcs
		f_perms.c
	)
endif()

if ( CONFIG_PERSPECTIVE_FILTER )
	list(APPEND device_srcs
		vf_perspective.c
	)
endif()

if ( CONFIG_PHASE_FILTER )
	list(APPEND device_srcs
		vf_phase.c
	)
endif()

if ( CONFIG_PHOTOSENSITIVITY_FILTER )
	list(APPEND device_srcs
		vf_photosensitivity.c
	)
endif()

if ( CONFIG_PIXDESCTEST_FILTER )
	list(APPEND device_srcs
		vf_pixdesctest.c
	)
endif()

if ( CONFIG_PIXELIZE_FILTER )
	list(APPEND device_srcs
		vf_pixelize.c
	)
endif()

if ( CONFIG_PIXSCOPE_FILTER )
	list(APPEND device_srcs
		vf_datascope.c
	)
endif()

if ( CONFIG_PP_FILTER )
	list(APPEND device_srcs
		vf_pp.c
		qp_table.c
	)
endif()

if ( CONFIG_PP7_FILTER )
	list(APPEND device_srcs
		vf_pp7.c
		qp_table.c
	)
endif()

if ( CONFIG_PREMULTIPLY_FILTER )
	list(APPEND device_srcs
		vf_premultiply.c
		framesync.c
	)
endif()

if ( CONFIG_PREWITT_FILTER )
	list(APPEND device_srcs
		vf_convolution.c
	)
endif()

if ( CONFIG_PREWITT_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_convolution_opencl.c
		opencl.c
		opencl/convolution.c
	)
endif()

if ( CONFIG_PROCAMP_VAAPI_FILTER )
	list(APPEND device_srcs
		vf_procamp_vaapi.c
		vaapi_vpp.c
	)
endif()

if ( CONFIG_PROGRAM_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_program_opencl.c
		opencl.c
		framesync.c
	)
endif()

if ( CONFIG_PSEUDOCOLOR_FILTER )
	list(APPEND device_srcs
		vf_pseudocolor.c
	)
endif()

if ( CONFIG_PSNR_FILTER )
	list(APPEND device_srcs
		vf_psnr.c
		framesync.c
	)
endif()

if ( CONFIG_PULLUP_FILTER )
	list(APPEND device_srcs
		vf_pullup.c
	)
endif()

if ( CONFIG_QP_FILTER )
	list(APPEND device_srcs
		vf_qp.c
	)
endif()

if ( CONFIG_RANDOM_FILTER )
	list(APPEND device_srcs
		vf_random.c
	)
endif()

if ( CONFIG_READEIA608_FILTER )
	list(APPEND device_srcs
		vf_readeia608.c
	)
endif()

if ( CONFIG_READVITC_FILTER )
	list(APPEND device_srcs
		vf_readvitc.c
	)
endif()

if ( CONFIG_REALTIME_FILTER )
	list(APPEND device_srcs
		f_realtime.c
	)
endif()

if ( CONFIG_REMAP_FILTER )
	list(APPEND device_srcs
		vf_remap.c
		framesync.c
	)
endif()

if ( CONFIG_REMAP_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_remap_opencl.c
		framesync.c
		opencl.c
		opencl/remap.c
	)
endif()

if ( CONFIG_REMOVEGRAIN_FILTER )
	list(APPEND device_srcs
		vf_removegrain.c
	)
endif()

if ( CONFIG_REMOVELOGO_FILTER )
	list(APPEND device_srcs
		bbox.c
		lswsutils.c
		lavfutils.c
		vf_removelogo.c
	)
endif()

if ( CONFIG_REPEATFIELDS_FILTER )
	list(APPEND device_srcs
		vf_repeatfields.c
	)
endif()

if ( CONFIG_REVERSE_FILTER )
	list(APPEND device_srcs
		f_reverse.c
	)
endif()

if ( CONFIG_RGBASHIFT_FILTER )
	list(APPEND device_srcs
		vf_chromashift.c
	)
endif()

if ( CONFIG_ROBERTS_FILTER )
	list(APPEND device_srcs
		vf_convolution.c
	)
endif()

if ( CONFIG_ROBERTS_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_convolution_opencl.c
		opencl.c
		opencl/convolution.c
	)
endif()

if ( CONFIG_ROTATE_FILTER )
	list(APPEND device_srcs
		vf_rotate.c
	)
endif()

if ( CONFIG_SAB_FILTER )
	list(APPEND device_srcs
		vf_sab.c
	)
endif()

if ( CONFIG_SCALE_FILTER )
	list(APPEND device_srcs
		vf_scale.c
		scale_eval.c
	)
endif()

if ( CONFIG_SCALE_CUDA_FILTER )
	list(APPEND device_srcs
		vf_scale_cuda.c
		scale_eval.c
		vf_scale_cuda.ptx.c
		cuda/load_helper.c
	)
endif()

if ( CONFIG_SCALE_NPP_FILTER )
	list(APPEND device_srcs
		vf_scale_npp.c
		scale_eval.c
	)
endif()

if ( CONFIG_SCALE_QSV_FILTER )
	list(APPEND device_srcs
		vf_scale_qsv.c
	)
endif()

if ( CONFIG_SCALE_VAAPI_FILTER )
	list(APPEND device_srcs
		vf_scale_vaapi.c
		scale_eval.c
		vaapi_vpp.c
	)
endif()

if ( CONFIG_SCALE_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_scale_vulkan.c
		vulkan.c
		vulkan_filter.c
	)
endif()

if ( CONFIG_SCALE2REF_FILTER )
	list(APPEND device_srcs
		vf_scale.c
		scale_eval.c
	)
endif()

if ( CONFIG_SCALE2REF_NPP_FILTER )
	list(APPEND device_srcs
		vf_scale_npp.c
		scale_eval.c
	)
endif()

if ( CONFIG_SCDET_FILTER )
	list(APPEND device_srcs
		vf_scdet.c
	)
endif()

if ( CONFIG_SCHARR_FILTER )
	list(APPEND device_srcs
		vf_convolution.c
	)
endif()

if ( CONFIG_SCROLL_FILTER )
	list(APPEND device_srcs
		vf_scroll.c
	)
endif()

if ( CONFIG_SEGMENT_FILTER )
	list(APPEND device_srcs
		f_segment.c
	)
endif()

if ( CONFIG_SELECT_FILTER )
	list(APPEND device_srcs
		f_select.c
	)
endif()

if ( CONFIG_SELECTIVECOLOR_FILTER )
	list(APPEND device_srcs
		vf_selectivecolor.c
	)
endif()

if ( CONFIG_SENDCMD_FILTER )
	list(APPEND device_srcs
		f_sendcmd.c
	)
endif()

if ( CONFIG_SEPARATEFIELDS_FILTER )
	list(APPEND device_srcs
		vf_separatefields.c
	)
endif()

if ( CONFIG_SETDAR_FILTER )
	list(APPEND device_srcs
		vf_aspect.c
	)
endif()

if ( CONFIG_SETFIELD_FILTER )
	list(APPEND device_srcs
		vf_setparams.c
	)
endif()

if ( CONFIG_SETPARAMS_FILTER )
	list(APPEND device_srcs
		vf_setparams.c
	)
endif()

if ( CONFIG_SETPTS_FILTER )
	list(APPEND device_srcs
		setpts.c
	)
endif()

if ( CONFIG_SETRANGE_FILTER )
	list(APPEND device_srcs
		vf_setparams.c
	)
endif()

if ( CONFIG_SETSAR_FILTER )
	list(APPEND device_srcs
		vf_aspect.c
	)
endif()

if ( CONFIG_SETTB_FILTER )
	list(APPEND device_srcs
		settb.c
	)
endif()

if ( CONFIG_SHARPEN_NPP_FILTER )
	list(APPEND device_srcs
		vf_sharpen_npp.c
	)
endif()

if ( CONFIG_SHARPNESS_VAAPI_FILTER )
	list(APPEND device_srcs
		vf_misc_vaapi.c
		vaapi_vpp.c
	)
endif()

if ( CONFIG_SHEAR_FILTER )
	list(APPEND device_srcs
		vf_shear.c
	)
endif()

if ( CONFIG_SHOWINFO_FILTER )
	list(APPEND device_srcs
		vf_showinfo.c
	)
endif()

if ( CONFIG_SHOWPALETTE_FILTER )
	list(APPEND device_srcs
		vf_showpalette.c
	)
endif()

if ( CONFIG_SHUFFLEFRAMES_FILTER )
	list(APPEND device_srcs
		vf_shuffleframes.c
	)
endif()

if ( CONFIG_SHUFFLEPIXELS_FILTER )
	list(APPEND device_srcs
		vf_shufflepixels.c
	)
endif()

if ( CONFIG_SHUFFLEPLANES_FILTER )
	list(APPEND device_srcs
		vf_shuffleplanes.c
	)
endif()

if ( CONFIG_SIDEDATA_FILTER )
	list(APPEND device_srcs
		f_sidedata.c
	)
endif()

if ( CONFIG_SIGNALSTATS_FILTER )
	list(APPEND device_srcs
		vf_signalstats.c
	)
endif()

if ( CONFIG_SIGNATURE_FILTER )
	list(APPEND device_srcs
		vf_signature.c
	)
endif()

if ( CONFIG_SMARTBLUR_FILTER )
	list(APPEND device_srcs
		vf_smartblur.c
	)
endif()

if ( CONFIG_SOBEL_FILTER )
	list(APPEND device_srcs
		vf_convolution.c
	)
endif()

if ( CONFIG_SOBEL_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_convolution_opencl.c
		opencl.c
		opencl/convolution.c
	)
endif()

if ( CONFIG_SITI_FILTER )
	list(APPEND device_srcs
		vf_siti.c
	)
endif()

if ( CONFIG_SPLIT_FILTER )
	list(APPEND device_srcs
		split.c
	)
endif()

if ( CONFIG_SPP_FILTER )
	list(APPEND device_srcs
		vf_spp.c
		qp_table.c
	)
endif()

if ( CONFIG_SR_FILTER )
	list(APPEND device_srcs
		vf_sr.c
	)
endif()

if ( CONFIG_SSIM_FILTER )
	list(APPEND device_srcs
		vf_ssim.c
		framesync.c
	)
endif()

if ( CONFIG_STEREO3D_FILTER )
	list(APPEND device_srcs
		vf_stereo3d.c
	)
endif()

if ( CONFIG_STREAMSELECT_FILTER )
	list(APPEND device_srcs
		f_streamselect.c
		framesync.c
	)
endif()

if ( CONFIG_SUBTITLES_FILTER )
	list(APPEND device_srcs
		vf_subtitles.c
	)
endif()

if ( CONFIG_SUPER2XSAI_FILTER )
	list(APPEND device_srcs
		vf_super2xsai.c
	)
endif()

if ( CONFIG_SWAPRECT_FILTER )
	list(APPEND device_srcs
		vf_swaprect.c
	)
endif()

if ( CONFIG_SWAPUV_FILTER )
	list(APPEND device_srcs
		vf_swapuv.c
	)
endif()

if ( CONFIG_TBLEND_FILTER )
	list(APPEND device_srcs
		vf_blend.c
		framesync.c
	)
endif()

if ( CONFIG_TELECINE_FILTER )
	list(APPEND device_srcs
		vf_telecine.c
	)
endif()

if ( CONFIG_THISTOGRAM_FILTER )
	list(APPEND device_srcs
		vf_histogram.c
	)
endif()

if ( CONFIG_THRESHOLD_FILTER )
	list(APPEND device_srcs
		vf_threshold.c
		framesync.c
	)
endif()

if ( CONFIG_THUMBNAIL_FILTER )
	list(APPEND device_srcs
		vf_thumbnail.c
	)
endif()

if ( CONFIG_THUMBNAIL_CUDA_FILTER )
	list(APPEND device_srcs
		vf_thumbnail_cuda.c
		vf_thumbnail_cuda.ptx.c
		cuda/load_helper.c
	)
endif()

if ( CONFIG_TILE_FILTER )
	list(APPEND device_srcs
		vf_tile.c
	)
endif()

if ( CONFIG_TINTERLACE_FILTER )
	list(APPEND device_srcs
		vf_tinterlace.c
	)
endif()

if ( CONFIG_TLUT2_FILTER )
	list(APPEND device_srcs
		vf_lut2.c
		framesync.c
	)
endif()

if ( CONFIG_TMEDIAN_FILTER )
	list(APPEND device_srcs
		vf_xmedian.c
		framesync.c
	)
endif()

if ( CONFIG_TMIDEQUALIZER_FILTER )
	list(APPEND device_srcs
		vf_tmidequalizer.c
	)
endif()

if ( CONFIG_TMIX_FILTER )
	list(APPEND device_srcs
		vf_mix.c
		framesync.c
	)
endif()

if ( CONFIG_TONEMAP_FILTER )
	list(APPEND device_srcs
		vf_tonemap.c
	)
endif()

if ( CONFIG_TONEMAP_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_tonemap_opencl.c
		opencl.c
		opencl/tonemap.c
		opencl/colorspace_common.c
	)
endif()

if ( CONFIG_TONEMAP_VAAPI_FILTER )
	list(APPEND device_srcs
		vf_tonemap_vaapi.c
		vaapi_vpp.c
	)
endif()

if ( CONFIG_TPAD_FILTER )
	list(APPEND device_srcs
		vf_tpad.c
	)
endif()

if ( CONFIG_TRANSPOSE_FILTER )
	list(APPEND device_srcs
		vf_transpose.c
	)
endif()

if ( CONFIG_TRANSPOSE_NPP_FILTER )
	list(APPEND device_srcs
		vf_transpose_npp.c
	)
endif()

if ( CONFIG_TRANSPOSE_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_transpose_opencl.c
		opencl.c
		opencl/transpose.c
	)
endif()

if ( CONFIG_TRANSPOSE_VAAPI_FILTER )
	list(APPEND device_srcs
		vf_transpose_vaapi.c
		vaapi_vpp.c
	)
endif()

if ( CONFIG_TRANSPOSE_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_transpose_vulkan.c
		vulkan.c
		vulkan_filter.c
	)
endif()

if ( CONFIG_TRIM_FILTER )
	list(APPEND device_srcs
		trim.c
	)
endif()

if ( CONFIG_UNPREMULTIPLY_FILTER )
	list(APPEND device_srcs
		vf_premultiply.c
		framesync.c
	)
endif()

if ( CONFIG_UNSHARP_FILTER )
	list(APPEND device_srcs
		vf_unsharp.c
	)
endif()

if ( CONFIG_UNSHARP_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_unsharp_opencl.c
		opencl.c
		opencl/unsharp.c
	)
endif()

if ( CONFIG_UNTILE_FILTER )
	list(APPEND device_srcs
		vf_untile.c
	)
endif()

if ( CONFIG_USPP_FILTER )
	list(APPEND device_srcs
		vf_uspp.c
		qp_table.c
	)
endif()

if ( CONFIG_V360_FILTER )
	list(APPEND device_srcs
		vf_v360.c
	)
endif()

if ( CONFIG_VAGUEDENOISER_FILTER )
	list(APPEND device_srcs
		vf_vaguedenoiser.c
	)
endif()

if ( CONFIG_VARBLUR_FILTER )
	list(APPEND device_srcs
		vf_varblur.c
		framesync.c
	)
endif()

if ( CONFIG_VECTORSCOPE_FILTER )
	list(APPEND device_srcs
		vf_vectorscope.c
	)
endif()

if ( CONFIG_VFLIP_FILTER )
	list(APPEND device_srcs
		vf_vflip.c
	)
endif()

if ( CONFIG_VFLIP_VULKAN_FILTER )
	list(APPEND device_srcs
		vf_flip_vulkan.c
		vulkan.c
	)
endif()

if ( CONFIG_VFRDET_FILTER )
	list(APPEND device_srcs
		vf_vfrdet.c
	)
endif()

if ( CONFIG_VIBRANCE_FILTER )
	list(APPEND device_srcs
		vf_vibrance.c
	)
endif()

if ( CONFIG_VIDSTABDETECT_FILTER )
	list(APPEND device_srcs
		vidstabutils.c
		vf_vidstabdetect.c
	)
endif()

if ( CONFIG_VIDSTABTRANSFORM_FILTER )
	list(APPEND device_srcs
		vidstabutils.c
		vf_vidstabtransform.c
	)
endif()

if ( CONFIG_VIF_FILTER )
	list(APPEND device_srcs
		vf_vif.c
		framesync.c
	)
endif()

if ( CONFIG_VIGNETTE_FILTER )
	list(APPEND device_srcs
		vf_vignette.c
	)
endif()

if ( CONFIG_VMAFMOTION_FILTER )
	list(APPEND device_srcs
		vf_vmafmotion.c
		framesync.c
	)
endif()

if ( CONFIG_VPP_QSV_FILTER )
	list(APPEND device_srcs
		vf_vpp_qsv.c
	)
endif()

if ( CONFIG_VSTACK_FILTER )
	list(APPEND device_srcs
		vf_stack.c
		framesync.c
	)
endif()

if ( CONFIG_W3FDIF_FILTER )
	list(APPEND device_srcs
		vf_w3fdif.c
	)
endif()

if ( CONFIG_WAVEFORM_FILTER )
	list(APPEND device_srcs
		vf_waveform.c
	)
endif()

if ( CONFIG_WEAVE_FILTER )
	list(APPEND device_srcs
		vf_weave.c
	)
endif()

if ( CONFIG_XBR_FILTER )
	list(APPEND device_srcs
		vf_xbr.c
	)
endif()

if ( CONFIG_XCORRELATE_FILTER )
	list(APPEND device_srcs
		vf_convolve.c
		framesync.c
	)
endif()

if ( CONFIG_XFADE_FILTER )
	list(APPEND device_srcs
		vf_xfade.c
	)
endif()

if ( CONFIG_XFADE_OPENCL_FILTER )
	list(APPEND device_srcs
		vf_xfade_opencl.c
		opencl.c
		opencl/xfade.c
	)
endif()

if ( CONFIG_XMEDIAN_FILTER )
	list(APPEND device_srcs
		vf_xmedian.c
		framesync.c
	)
endif()

if ( CONFIG_XSTACK_FILTER )
	list(APPEND device_srcs
		vf_stack.c
		framesync.c
	)
endif()

if ( CONFIG_YADIF_FILTER )
	list(APPEND device_srcs
		vf_yadif.c
		yadif_common.c
	)
endif()

if ( CONFIG_YADIF_CUDA_FILTER )
	list(APPEND device_srcs
		vf_yadif_cuda.c
		vf_yadif_cuda.ptx.c
		yadif_common.c
		cuda/load_helper.c
	)
endif()

if ( CONFIG_YADIF_VIDEOTOOLBOX_FILTER )
	list(APPEND device_srcs
		vf_yadif_videotoolbox.c
		metal/vf_yadif_videotoolbox.metallib.c
		metal/utils.c
		yadif_common.c
	)
endif()

if ( CONFIG_YAEPBLUR_FILTER )
	list(APPEND device_srcs
		vf_yaepblur.c
	)
endif()

if ( CONFIG_ZMQ_FILTER )
	list(APPEND device_srcs
		f_zmq.c
	)
endif()

if ( CONFIG_ZOOMPAN_FILTER )
	list(APPEND device_srcs
		vf_zoompan.c
	)
endif()

if ( CONFIG_ZSCALE_FILTER )
	list(APPEND device_srcs
		vf_zscale.c
	)
endif()


if ( CONFIG_ALLRGB_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_ALLYUV_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_CELLAUTO_FILTER )
	list(APPEND device_srcs
		vsrc_cellauto.c
	)
endif()

if ( CONFIG_COLOR_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_COLORCHART_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_COLORSPECTRUM_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_COREIMAGESRC_FILTER )
	list(APPEND device_srcs
		vf_coreimage.c
	)
endif()

if ( CONFIG_FREI0R_SRC_FILTER )
	list(APPEND device_srcs
		vf_frei0r.c
	)
endif()

if ( CONFIG_GRADIENTS_FILTER )
	list(APPEND device_srcs
		vsrc_gradients.c
	)
endif()

if ( CONFIG_HALDCLUTSRC_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_LIFE_FILTER )
	list(APPEND device_srcs
		vsrc_life.c
	)
endif()

if ( CONFIG_MANDELBROT_FILTER )
	list(APPEND device_srcs
		vsrc_mandelbrot.c
	)
endif()

if ( CONFIG_MPTESTSRC_FILTER )
	list(APPEND device_srcs
		vsrc_mptestsrc.c
	)
endif()

if ( CONFIG_NULLSRC_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_OPENCLSRC_FILTER )
	list(APPEND device_srcs
		vf_program_opencl.c
		opencl.c
	)
endif()

if ( CONFIG_PAL75BARS_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_PAL100BARS_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_RGBTESTSRC_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_SIERPINSKI_FILTER )
	list(APPEND device_srcs
		vsrc_sierpinski.c
	)
endif()

if ( CONFIG_SMPTEBARS_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_SMPTEHDBARS_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_TESTSRC_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_TESTSRC2_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()

if ( CONFIG_YUVTESTSRC_FILTER )
	list(APPEND device_srcs
		vsrc_testsrc.c
	)
endif()


if ( CONFIG_NULLSINK_FILTER )
	list(APPEND device_srcs
		vsink_nullsink.c
	)
endif()


# multimedia filters
if ( CONFIG_ABITSCOPE_FILTER )
	list(APPEND device_srcs
		avf_abitscope.c
	)
endif()

if ( CONFIG_ADRAWGRAPH_FILTER )
	list(APPEND device_srcs
		f_drawgraph.c
	)
endif()

if ( CONFIG_AGRAPHMONITOR_FILTER )
	list(APPEND device_srcs
		f_graphmonitor.c
	)
endif()

if ( CONFIG_AHISTOGRAM_FILTER )
	list(APPEND device_srcs
		avf_ahistogram.c
	)
endif()

if ( CONFIG_APHASEMETER_FILTER )
	list(APPEND device_srcs
		avf_aphasemeter.c
	)
endif()

if ( CONFIG_AVECTORSCOPE_FILTER )
	list(APPEND device_srcs
		avf_avectorscope.c
	)
endif()

if ( CONFIG_CONCAT_FILTER )
	list(APPEND device_srcs
		avf_concat.c
	)
endif()

if ( CONFIG_SHOWCQT_FILTER )
	list(APPEND device_srcs
		avf_showcqt.c
		lswsutils.c
		lavfutils.c
	)
endif()

if ( CONFIG_SHOWFREQS_FILTER )
	list(APPEND device_srcs
		avf_showfreqs.c
	)
endif()

if ( CONFIG_SHOWSPATIAL_FILTER )
	list(APPEND device_srcs
		avf_showspatial.c
	)
endif()

if ( CONFIG_SHOWSPECTRUM_FILTER )
	list(APPEND device_srcs
		avf_showspectrum.c
	)
endif()

if ( CONFIG_SHOWSPECTRUMPIC_FILTER )
	list(APPEND device_srcs
		avf_showspectrum.c
	)
endif()

if ( CONFIG_SHOWVOLUME_FILTER )
	list(APPEND device_srcs
		avf_showvolume.c
	)
endif()

if ( CONFIG_SHOWWAVES_FILTER )
	list(APPEND device_srcs
		avf_showwaves.c
	)
endif()

if ( CONFIG_SHOWWAVESPIC_FILTER )
	list(APPEND device_srcs
		avf_showwaves.c
	)
endif()

if ( CONFIG_SPECTRUMSYNTH_FILTER )
	list(APPEND device_srcs
		vaf_spectrumsynth.c
	)
endif()


# multimedia sources
if ( CONFIG_AVSYNCTEST_FILTER )
	list(APPEND device_srcs
		src_avsynctest.c
	)
endif()

if ( CONFIG_AMOVIE_FILTER )
	list(APPEND device_srcs
		src_movie.c
	)
endif()

if ( CONFIG_MOVIE_FILTER )
	list(APPEND device_srcs
		src_movie.c
	)
endif()


list(REMOVE_DUPLICATES device_srcs)

target_include_directories(libavfilter 
	PRIVATE 
	${FFMPEG_INCLUDE_HEADER_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}/../avutil/
)

target_link_directories(libavfilter
	PRIVATE 
	${FFMPEG_INCLUDE_HEADER_DIR}
	${CMAKE_CURRENT_SOURCE_DIR}/../avutil/
)

IF( device_srcs )
  add_library(libavfilter_aux OBJECT ${device_srcs})
	target_include_directories(libavfilter_aux PRIVATE ${AV_DIR})
  target_include_directories(libavfilter_aux AFTER PRIVATE ${FFMPEG_CONFIG_HEADER_DIR})

	target_compile_options(libavfilter_aux PUBLIC -DHAVE_AV_CONFIG_H=1)
	target_compile_options(libavfilter_aux INTERFACE ${LIBAVFILTER_C_FLAGS})

	target_include_directories(libavfilter_aux 
		INTERFACE ${FFMPEG_INCLUDE_HEADER_DIR}
		PRIVATE ${FFMPEG_INCLUDE_HEADER_DIR}libavutil
	)
	
	target_link_directories(libavfilter_aux 
		INTERFACE ${FFMPEG_INCLUDE_HEADER_DIR}
		PRIVATE ${FFMPEG_INCLUDE_HEADER_DIR}libavutil
	)

	if (FFMPEG_CONFIG_DNN )
		target_include_directories(libavfilter_aux AFTER PRIVATE ${DNN_DIR})
	endif()

  target_link_libraries(libavfilter libavfilter_aux)
ENDIF()


list(APPEND EXTRA_LIBS libavfilter)