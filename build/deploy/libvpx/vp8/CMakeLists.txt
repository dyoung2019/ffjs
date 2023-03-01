if (CONFIG_VP8)

  add_library(vp8_common OBJECT 
    common/alloccommon.c
    common/blockd.c

    common/dequantize.c
    common/entropy.c
    common/entropymode.c
    common/entropymv.c
    common/extend.c
    common/filter.c
    common/findnearmv.c
    common/generic/systemdependent.c
    common/idct_blk.c
    common/idctllm.c

    common/rtcd.c
    common/rtcd_defs.pl

    common/vp8_loopfilter.c
    common/loopfilter_filters.c
    common/mbpitch.c
    common/modecont.c
    common/quant_common.c
    common/reconinter.c
    common/reconintra.c
    common/reconintra4x4.c
    common/setupintrarecon.c
    common/swapyv12buffer.c

    common/treecoder.c
  )

  set(extra_srcs)

  if (VPX_ARCH_X86 AND VPX_ARCH_X86_64)
    LIST(APPEND extra_srcs
      common/x86/vp8_asm_stubs.c
      common/x86/loopfilter_x86.c
    )
  endif()

  if (CONFIG_POSTPROC)
    LIST(APPEND extra_srcs
      common/mfqe.c
      common/postproc.c
    )
  endif()

  if (HAVE_MMX)
    LIST(APPEND extra_srcs
      common/x86/idct_blk_mmx.c
    )
  endif()

  if (HAVE_SSE2)
    LIST(APPEND extra_srcs
      common/x86/idct_blk_sse2.c
      common/x86/bilinear_filter_sse2.c
    )
  endif()

  if (HAVE_DSPR2)
    LIST(APPEND extra_srcs
      common/mips/dspr2/idctllm_dspr2.c
      common/mips/dspr2/filter_dspr2.c
      common/mips/dspr2/vp8_loopfilter_filters_dspr2.c
      common/mips/dspr2/reconinter_dspr2.c
      common/mips/dspr2/idct_blk_dspr2.c
      common/mips/dspr2/dequantize_dspr2.c
    )
  endif()

  if (HAVE_MSA)
    LIST(APPEND extra_srcs
      common/mips/msa/bilinear_filter_msa.c
      common/mips/msa/copymem_msa.c
      common/mips/msa/idct_msa.c
      common/mips/msa/loopfilter_filters_msa.c
      common/mips/msa/sixtap_filter_msa.c
    )
  endif()

  if (HAVE_MMI)
    LIST(APPEND extra_srcs
      common/mips/mmi/sixtap_filter_mmi.c
      common/mips/mmi/loopfilter_filters_mmi.c
      common/mips/mmi/idctllm_mmi.c
      common/mips/mmi/dequantize_mmi.c
      common/mips/mmi/copymem_mmi.c
      common/mips/mmi/idct_blk_mmi.c
    )
  endif()

  if (CONFIG_POSTPROC) 
    if (HAVE_MMI)
      LIST(APPEND extra_srcs
        common/mips/msa/mfqe_msa.c
      )
    endif()
  endif()

  if (HAVE_LSX) 
    LIST(APPEND extra_srcs
      common/loongarch/loopfilter_filters_lsx.c
      common/loongarch/sixtap_filter_lsx.c
      common/loongarch/idct_lsx.c
    )
  endif()

  if (HAVE_NEON) 
    LIST(APPEND extra_srcs
      common/arm/loopfilter_arm.c
      common/arm/neon/bilinearpredict_neon.c
      common/arm/neon/copymem_neon.c
      common/arm/neon/dc_only_idct_add_neon.c
      common/arm/neon/dequant_idct_neon.c
      common/arm/neon/dequantizeb_neon.c
      common/arm/neon/idct_blk_neon.c
      common/arm/neon/iwalsh_neon.c
      common/arm/neon/vp8_loopfilter_neon.c
      common/arm/neon/loopfiltersimplehorizontaledge_neon.c
      common/arm/neon/loopfiltersimpleverticaledge_neon.c
      common/arm/neon/mbloopfilter_neon.c
      common/arm/neon/shortidct4x4llm_neon.c
      common/arm/neon/sixtappredict_neon.c
    )
  endif()

  list(REMOVE_DUPLICATES extra_srcs)

  IF( extra_srcs )
    add_library(vp8_common_aux1 OBJECT ${extra_srcs})
    
    target_include_directories(vp8_common_aux1 
      PUBLIC ${LIBVPX_ROOT_DIR})

    target_link_libraries(vp8_common vp8_common_aux1)
  ENDIF()

  target_include_directories(vp8_common 
    PUBLIC ${LIBVPX_ROOT_DIR})

  LIST(APPEND VPX_MODULES vp8_common)
endif()

if(CONFIG_VP8_ENCODER) 
  set(vp8_enc)

  LIST(APPEND vp8_enc
    vp8_cx_iface.c
    encoder/bitstream.c
    encoder/boolhuff.c
    encoder/copy_c.c
    encoder/dct.c
    encoder/encodeframe.c
    encoder/encodeintra.c
    encoder/encodemb.c
    encoder/encodemv.c
    encoder/firstpass.c
    encoder/lookahead.c
    encoder/mcomp.c
    encoder/modecosts.c
    encoder/onyx_if.c
    encoder/pickinter.c
    encoder/picklpf.c
    encoder/vp8_quantize.c
    encoder/ratectrl.c
    encoder/rdopt.c
    encoder/segmentation.c
    common/vp8_skin_detection.c
    encoder/tokenize.c
    encoder/treewriter.c
    encoder/temporal_filter.c
  )

  if (CONFIG_MULTITHREAD) 
    list(APPEND vp8_enc
      encoder/ethreading.c
    )
  endif()

  if (CONFIG_TEMPORAL_DENOISING) 
    list(APPEND vp8_enc
      encoder/denoising.c
    )
  endif()

  if (CONFIG_INTERNAL_STATS) 
    list(APPEND vp8_enc
      common/postproc.c
    )
  endif()

  if (CONFIG_MULTI_RES_ENCODING) 
    list(APPEND vp8_enc
      encoder/mr_dissim.c
    )
  endif()

  if (CONFIG_REALTIME_ONLY) 
    list(REMOVE vp8_enc
      encoder/firstpass.c
      encoder/temporal_filter.c
    )
  endif()

  if (HAVE_SSE2) 
    list(APPEND vp8_enc
      encoder/x86/vp8_quantize_sse2.c
      encoder/x86/vp8_enc_stubs_sse2.c
    )
  endif()

  if (HAVE_SSSE3) 
    list(APPEND vp8_enc
      encoder/x86/vp8_quantize_ssse3.c
    )
  endif()

  if (HAVE_SSE4_1) 
    list(APPEND vp8_enc
      encoder/x86/quantize_sse4.c
    )
  endif()

  if (CONFIG_TEMPORAL_DENOISING) 
    if (HAVE_SSE2) 
      list(APPEND vp8_enc
        encoder/x86/denoising_sse2.c
      )
    endif()
  endif()
  
  if (HAVE_NEON) 
    list(APPEND vp8_enc
      encoder/arm/neon/denoising_neon.c
      encoder/arm/neon/fastquantizeb_neon.c
      encoder/arm/neon/shortfdct_neon.c
      encoder/arm/neon/vp8_shortwalsh4x4_neon.c
    )
  endif()

  if (HAVE_MSA) 
    list(APPEND vp8_enc
      encoder/mips/msa/dct_msa.c
      encoder/mips/msa/encodeopt_msa.c
      encoder/mips/msa/quantize_msa.c
      encoder/mips/msa/temporal_filter_msa.c
    )
  endif()

  if (HAVE_MMI) 
    list(APPEND vp8_enc
      encoder/mips/mmi/vp8_quantize_mmi.c
      encoder/mips/mmi/dct_mmi.c
    )
  endif()

  if (CONFIG_TEMPORAL_DENOISING) 
    if (HAVE_MSA) 
      list(APPEND vp8_enc
        encoder/mips/msa/denoising_msa.c
      )
    endif()
  endif()

  if (CONFIG_TEMPORAL_DENOISING) 
    if (HAVE_MSA) 
      list(APPEND vp8_enc
        encoder/mips/msa/temporal_filter_msa.c
      )
    endif()
  endif()

  if (CONFIG_TEMPORAL_DENOISING) 
    if (HAVE_LSX) 
      list(APPEND vp8_enc
        # common (loongarch LSX intrinsics)
          encoder/loongarch/dct_lsx.c
          encoder/loongarch/encodeopt_lsx.c
          encoder/loongarch/vp8_quantize_lsx.c
      )
    endif()
  endif()

  list(REMOVE_DUPLICATES vp8_enc)

  add_library(vp8_encoder OBJECT ${vp8_enc})
    
  target_include_directories(vp8_encoder 
    PUBLIC ${LIBVPX_ROOT_DIR})

  LIST(APPEND VPX_MODULES vp8_encoder)
endif()
# if (CONFIG_VP8_DECODER) 
#   deploy_vpx_module(vp8dx)
# endif()