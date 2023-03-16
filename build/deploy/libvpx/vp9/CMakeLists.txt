cmake_minimum_required(VERSION 3.22)
message(VAR(vp9_common) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

if (CONFIG_VP9)
  message(VAR(vp9_common) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

  add_library(vp9_common OBJECT 
    vp9_iface_common.c
    common/vp9_alloccommon.c
    common/vp9_blockd.c
    common/vp9_entropy.c
    common/vp9_entropymode.c
    common/vp9_entropymv.c
    common/vp9_frame_buffers.c
    common/vp9_idct.c
    common/vp9_filter.c
    common/vp9_rtcd.c
    common/vp9_rtcd_defs.pl
    common/vp9_scale.c
    common/vp9_seg_common.c
    common/vp9_tile_common.c
    common/vp9_loopfilter.c
    common/vp9_thread_common.c
    common/vp9_mvref_common.c
    common/vp9_quant_common.c
    common/vp9_reconinter.c
    common/vp9_reconintra.c
    common/vp9_common_data.c
    common/vp9_scan.c
  )

  set(extra_srcs)

  if (CONFIG_VP9_POSTPROC)
    LIST(APPEND extra_srcs
      common/vp9_postproc.c
      common/vp9_mfqe.c
    )
  endif()

  if (!CONFIG_VP9_HIGHBITDEPTH)
    if (HAVE_MSA)
      LIST(APPEND extra_srcs
        common/mips/msa/vp9_idct4x4_msa.c
        common/mips/msa/vp9_idct8x8_msa.c
        common/mips/msa/vp9_idct16x16_msa.c
      )
    endif()

    if (HAVE_DSPR2)
      LIST(APPEND extra_srcs
        common/mips/dspr2/vp9_itrans4_dspr2.c
        common/mips/dspr2/vp9_itrans8_dspr2.c
        common/mips/dspr2/vp9_itrans16_dspr2.c
      )
    endif()
  else(!CONFIG_VP9_HIGHBITDEPTH)
    if (HAVE_NEON)
      LIST(APPEND extra_srcs
        common/arm/neon/vp9_highbd_iht4x4_add_neon.c
        common/arm/neon/vp9_highbd_iht8x8_add_neon.c
        common/arm/neon/vp9_highbd_iht16x16_add_neon.c
      )
    endif()

    if (HAVE_SSE4_1)
      LIST(APPEND extra_srcs
        common/x86/vp9_highbd_iht4x4_add_sse4.c
        common/x86/vp9_highbd_iht8x8_add_sse4.c
        common/x86/vp9_highbd_iht16x16_add_sse4.c
      )
    endif()
  endif()


  if (HAVE_SSE2)
    LIST(APPEND extra_srcs
      common/x86/vp9_idct_intrin_sse2.c
    )
  endif()

  if (HAVE_VSX)
    LIST(APPEND extra_srcs
      common/ppc/vp9_idct_vsx.c
    )
  endif()

  if (HAVE_NEON)
    LIST(APPEND extra_srcs
      common/arm/neon/vp9_iht4x4_add_neon.c
      common/arm/neon/vp9_iht8x8_add_neon.c
      common/arm/neon/vp9_iht16x16_add_neon.c
    )
  endif()  

  if (CONFIG_VP9_POSTPROC)
    if (HAVE_MSA)
      LIST(APPEND extra_srcs
        common/mips/msa/vp9_mfqe_msa.c
      )
    endif()
  endif()

  list(REMOVE_DUPLICATES extra_srcs)

  IF( extra_srcs )
    add_library(vp9_common_aux1 OBJECT ${extra_srcs})
    
    target_include_directories(vp9_common_aux1 
      PUBLIC ${LIBVPX_ROOT_DIR})

    target_link_libraries(vp9_common vp9_common_aux1)
  ENDIF()

  target_include_directories(vp9_common 
    PUBLIC ${LIBVPX_ROOT_DIR})

endif()

if(CONFIG_VP9_ENCODER) 
  set(vp9_enc)

  LIST(APPEND vp9_enc
    vp9_cx_iface.c
    encoder/vp9_bitstream.c
    encoder/vp9_context_tree.c
    encoder/vp9_cost.c
    encoder/vp9_dct.c
    encoder/vp9_encodeframe.c
    encoder/vp9_encodemb.c
    encoder/vp9_encodemv.c
    encoder/vp9_ethread.c
    encoder/vp9_extend.c
    encoder/vp9_firstpass.c
    encoder/vp9_frame_scale.c
    encoder/vp9_lookahead.c
    encoder/vp9_multi_thread.c
    encoder/vp9_mcomp.c
    encoder/vp9_encoder.c
    encoder/vp9_picklpf.c
    encoder/vp9_quantize.c
    encoder/vp9_ratectrl.c
    encoder/vp9_rd.c
    encoder/vp9_rdopt.c
    encoder/vp9_pickmode.c
    encoder/vp9_segmentation.c
    encoder/vp9_speed_features.c
    encoder/vp9_subexp.c
    encoder/vp9_svc_layercontext.c
    encoder/vp9_resize.c
    encoder/vp9_tokenize.c
    encoder/vp9_treewriter.c
    encoder/vp9_aq_variance.c
    encoder/vp9_aq_360.c
    encoder/vp9_aq_cyclicrefresh.c
    encoder/vp9_aq_complexity.c
    encoder/vp9_alt_ref_aq.c
    encoder/vp9_skin_detection.c
    encoder/vp9_noise_estimate.c
    encoder/vp9_ext_ratectrl.c

    encoder/vp9_temporal_filter.c
    encoder/vp9_tpl_model.c
    encoder/vp9_mbgraph.c
  )

  if (CONFIG_VP9_TEMPORAL_DENOISING)
    list(APPEND vp9_enc
      encoder/vp9_denoiser.c
    )
  endif()

  if (CONFIG_INTERNAL_STATS)
    list(APPEND vp9_enc
        encoder/vp9_blockiness.c
    )
  endif()

  if (CONFIG_NON_GREEDY_MV)
    list(APPEND vp9_enc
      encoder/vp9_non_greedy_mv.c
    )
  endif()

  if (CONFIG_VP9_POSTPROC)
    if (CONFIG_INTERNAL_STATS)
      list(APPEND vp9_enc
        common/vp9_postproc.c
      )
    endif()
  endif()

  if (HAVE_SSE4_1)
    list(APPEND vp9_enc
      encoder/x86/temporal_filter_sse4.c
    )
  endif()

  if (HAVE_SSE2)
    list(APPEND vp9_enc
      encoder/x86/vp9_quantize_sse2.c
      encoder/x86/vp9_dct_intrin_sse2.c
    )
  endif()

  if (HAVE_SSSE3)
    list(APPEND vp9_enc
      encoder/x86/vp9_quantize_ssse3.c
      encoder/x86/vp9_frame_scale_ssse3.c
    )
  endif()

  if (HAVE_AVX2)
    list(APPEND vp9_enc
      encoder/x86/vp9_quantize_avx2.c
      encoder/x86/vp9_error_avx2.c
    )
  endif()

  if (HAVE_AVX)
    list(APPEND vp9_enc
      encoder/x86/vp9_diamond_search_sad_avx.c
    )
  endif()

  if (HAVE_NEON)
    list(APPEND vp9_enc
      encoder/arm/neon/vp9_diamond_search_sad_neon.c
      encoder/arm/neon/vp9_dct_neon.c

      encoder/arm/neon/vp9_frame_scale_neon.c
      encoder/arm/neon/vp9_quantize_neon.c
    )
  endif()

  if (CONFIG_VP9_HIGHBITDEPTH)
    if (HAVE_SSE2)
      list(APPEND vp9_enc
        encoder/x86/vp9_highbd_block_error_intrin_sse2.c
      )
    endif()

    if (HAVE_SSE4_1)
      list(APPEND vp9_enc
        encoder/x86/highbd_temporal_filter_sse4.c
      )
    endif()

    if (HAVE_NEON)
      list(APPEND vp9_enc
        encoder/arm/neon/vp9_error_neon.c
      )
    endif()

    if (HAVE_MSA)
      list(APPEND vp9_enc
        encoder/mips/msa/vp9_fdct4x4_msa.c
        encoder/mips/msa/vp9_fdct8x8_msa.c
        encoder/mips/msa/vp9_fdct16x16_msa.c
      )
    endif()
  endif()

  if (CONFIG_VP9_TEMPORAL_DENOISING)
    if (HAVE_SSE2)
      list(APPEND vp9_enc
        encoder/x86/vp9_denoiser_sse2.c
      )
    endif()

    if (HAVE_NEON)
      list(APPEND vp9_enc
        encoder/arm/neon/vp9_denoiser_neon.c
      )
    endif()    
  endif()

  if (HAVE_MSA)
    list(APPEND vp9_enc
      encoder/mips/msa/vp9_error_msa.c
    )
  endif()

  if (HAVE_VSX)
    list(APPEND vp9_enc
      encoder/ppc/vp9_quantize_vsx.c
    )
  endif()

  if (CONFIG_REALTIME_ONLY)
    list(REMOVE vp9_enc
      encoder/vp9_firstpass.c
      encoder/vp9_mbgraph.c
      encoder/vp9_temporal_filter.c
      encoder/x86/temporal_filter_sse4.c
      encoder/x86/highbd_temporal_filter_sse4.c
      encoder/vp9_alt_ref_aq.c
      encoder/vp9_aq_variance.c
      encoder/vp9_aq_360.c
      encoder/vp9_aq_complexity.c      
    )
  endif()

  list(REMOVE_DUPLICATES vp9_enc)

  add_library(vp9_encoder OBJECT ${vp9_enc})
    
  target_include_directories(vp9_encoder 
    PUBLIC ${LIBVPX_ROOT_DIR})

endif()

if (CONFIG_VP9_DECODER)

  add_library(vp9_decoder OBJECT
    vp9_dx_iface.c
    decoder/vp9_decodemv.c
    decoder/vp9_decodeframe.c
    decoder/vp9_detokenize.c
    decoder/vp9_decoder.c
    decoder/vp9_dsubexp.c
    decoder/vp9_job_queue.c
  )

  target_include_directories(vp9_decoder 
    PUBLIC ${LIBVPX_ROOT_DIR})

endif()