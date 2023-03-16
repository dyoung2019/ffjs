cmake_minimum_required(VERSION 3.22)
message(VAR(vpx_dsp) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

add_library(vpx_dsp OBJECT
  prob.c
  intrapred.c
  skin_detection.c
  vpx_dsp_rtcd.c
)

# set(vpx_dsp_srcs)

if (CONFIG_ENCODERS)
  LIST(APPEND vpx_dsp_srcs
    bitwriter.c
    bitwriter_buffer.c
    psnr.c

    sad.c
    subtract.c
    sum_squares.c    
  )

  if (CONFIG_INTERNAL_STATS)
    LIST(APPEND vpx_dsp_srcs
      ssim.c
      psnrhvs.c
      fastssim.c
    )
  endif()

  if (HAVE_NEON)
    LIST(APPEND vpx_dsp_srcs
      arm/sum_squares_neon.c

      arm/sad4d_neon.c
      arm/sad_neon.c
      arm/subtract_neon.c      
    )
  endif()

  if (HAVE_SSE2)
    LIST(APPEND vpx_dsp_srcs
      x86/sum_squares_sse2.c
    )
  endif()  

  if (HAVE_MSA)
    LIST(APPEND vpx_dsp_srcs
      mips/sum_squares_msa.c
      mips/sad_msa.c
      mips/subtract_msa.c      
    )
  endif()   

  if (HAVE_SSE2)
    LIST(APPEND vpx_dsp_srcs
      loongarch/sad_lsx.c
    )
  endif() 
  
  if (HAVE_MMI)
    LIST(APPEND vpx_dsp_srcs
      mips/sad_mmi.c
      mips/subtract_mmi.c
    )
  endif()

  if (HAVE_AVX2)
    LIST(APPEND vpx_dsp_srcs
      x86/sad4d_avx2.c
      x86/sad_avx2.c
      x86/subtract_avx2.c
    )
  endif() 
  
  if (HAVE_AVX512)
    LIST(APPEND vpx_dsp_srcs
      x86/sad4d_avx512.c
    )
  endif() 

  if (HAVE_VSX)
    LIST(APPEND vpx_dsp_srcs
      ppc/sad_vsx.c
      ppc/subtract_vsx.c
    )
  endif() 

  if (HAVE_LSX)
    LIST(APPEND vpx_dsp_srcs
      loongarch/subtract_lsx.c
    )
  endif()

  if (CONFIG_VP9_HIGHBITDEPTH)
    if (HAVE_NEON)
      LIST(APPEND vpx_dsp_srcs
        arm/highbd_sad4d_neon.c
        arm/highbd_sad_neon.c
      )
    endif()

    if (HAVE_AVX2)
      LIST(APPEND vpx_dsp_srcs
        x86/highbd_sad4d_avx2.c
        x86/highbd_sad_avx2.c
      )
    endif()    
  endif()

endif()

if (CONFIG_DECODERS)
  LIST(APPEND vpx_dsp_srcs
    bitreader.c
    bitreader_buffer.c
  )
endif()

if (HAVE_VSX)
  LIST(APPEND vpx_dsp_srcs
    ppc/intrapred_vsx.c
  )
endif()

if (CONFIG_VP9_HIGHBITDEPTH)
  if (HAVE_SSE2)
    LIST(APPEND vpx_dsp_srcs
      x86/highbd_intrapred_intrin_sse2.c
    )
  endif()

  if (HAVE_SSSE3)
    LIST(APPEND vpx_dsp_srcs
      x86/highbd_intrapred_intrin_ssse3.c
    )
  endif()

  if (HAVE_NEON)
    LIST(APPEND vpx_dsp_srcs
      arm/highbd_intrapred_neon.c
    )
  endif()
endif()

if (NOT (CONFIG_POSTPROC OR CONFIG_VP9_POSTPROC) ) 
  LIST(APPEND vpx_dsp_srcs
    add_noise.c
    deblock.c
  )

  if (HAVE_MSA)
    LIST(APPEND vpx_dsp_srcs
      mips/add_noise_msa.c
      mips/deblock_msa.c
    )
  endif()

  if (HAVE_NEON)
    LIST(APPEND vpx_dsp_srcs
      arm/deblock_neon.c
    )
  endif()

  if (HAVE_SSE2)
    LIST(APPEND vpx_dsp_srcs
      x86/post_proc_sse2.c
    )
  endif()

  if (HAVE_VSX)
    LIST(APPEND vpx_dsp_srcs
      ppc/deblock_vsx.c
    )
  endif()
endif()

if (HAVE_NEON)
  LIST(APPEND vpx_dsp_srcs
    arm/intrapred_neon.c
  )
endif()

if (HAVE_MSA)
  LIST(APPEND vpx_dsp_srcs
    mips/intrapred_msa.c
  )
endif()

if (HAVE_LSX)
  LIST(APPEND vpx_dsp_srcs
    loongarch/intrapred_lsx.c
  )
endif()

if (HAVE_DSPR2)
  LIST(APPEND vpx_dsp_srcs
    mips/intrapred4_dspr2.c
    mips/intrapred8_dspr2.c
    mips/intrapred16_dspr2.c
    mips/common_dspr2.c
  )
endif()

if (CONFIG_VP9)
  LIST(APPEND vpx_dsp_srcs
    vpx_convolve.c
    loopfilter.c
    inv_txfm.c
  )

  if (HAVE_SSE2)
    LIST(APPEND vpx_dsp_srcs
      x86/vpx_subpixel_4t_intrin_sse2.c
      x86/loopfilter_sse2.c
      x86/inv_txfm_sse2.c
    )
  endif()

  if (HAVE_AVX2)
    LIST(APPEND vpx_dsp_srcs
      x86/vpx_subpixel_8t_intrin_avx2.c
      x86/loopfilter_avx2.c
    )
  endif()

  if (HAVE_SSSE3)
    LIST(APPEND vpx_dsp_srcs
      x86/vpx_subpixel_8t_intrin_ssse3.c
      x86/inv_txfm_ssse3.c
    )
  endif()

  if (HAVE_VSX)
    LIST(APPEND vpx_dsp_srcs
      x86/vpx_subpixel_8t_intrin_ssse3.c
    )
  endif()

  if (CONFIG_VP9_HIGHBITDEPTH)
    if (HAVE_AVX2)
      LIST(APPEND vpx_dsp_srcs
        x86/highbd_convolve_avx2.c
      )
    endif()

    if (HAVE_NEON)
      LIST(APPEND vpx_dsp_srcs
        arm/highbd_vpx_convolve_copy_neon.c
        arm/highbd_vpx_convolve_avg_neon.c
        arm/highbd_vpx_convolve8_neon.c
        arm/highbd_vpx_convolve_neon.c

        arm/highbd_loopfilter_neon.c
      )
    endif()
  
    if (HAVE_SSE2)
      LIST(APPEND vpx_dsp_srcs
        x86/highbd_loopfilter_sse2.c
      )
    endif()

    if (HAVE_DSPR2)
      LIST(APPEND vpx_dsp_srcs
        mips/itrans4_dspr2.c
        mips/itrans8_dspr2.c
        mips/itrans16_dspr2.c
        mips/itrans32_dspr2.c
        mips/itrans32_cols_dspr2.c
      )
    endif()

    if (HAVE_DSPR2)
      LIST(APPEND vpx_dsp_srcs
        loongarch/idct32x32_lsx.c
      )
    endif()
  else(CONFIG_VP9_HIGHBITDEPTH)
    if (HAVE_NEON)
      LIST(APPEND vpx_dsp_srcs
        arm/highbd_idct4x4_add_neon.c
        arm/highbd_idct8x8_add_neon.c
        arm/highbd_idct16x16_add_neon.c
        arm/highbd_idct32x32_add_neon.c
        arm/highbd_idct32x32_34_add_neon.c
        arm/highbd_idct32x32_135_add_neon.c
        arm/highbd_idct32x32_1024_add_neon.c
      )
    endif()

    if (HAVE_SSE2)
      LIST(APPEND vpx_dsp_srcs
        x86/highbd_idct4x4_add_sse2.c
        x86/highbd_idct8x8_add_sse2.c
        x86/highbd_idct16x16_add_sse2.c
        x86/highbd_idct32x32_add_sse2.c
      )
    endif()

    if (HAVE_SSE4_1)
      LIST(APPEND vpx_dsp_srcs
        x86/highbd_idct4x4_add_sse4.c
        x86/highbd_idct8x8_add_sse4.c
        x86/highbd_idct16x16_add_sse4.c
        x86/highbd_idct32x32_add_sse4.c
      )
    endif()
  endif()

  if (HAVE_NEON)
    LIST(APPEND vpx_dsp_srcs
      arm/vpx_scaled_convolve8_neon.c
    )
  endif()

  if (HAVE_NEON_ASM)
    LIST(APPEND vpx_dsp_srcs
      arm/vpx_convolve8_neon_asm.c
      arm/vpx_convolve_neon.c
    )

    if (HAVE_NEON)
      LIST(APPEND vpx_dsp_srcs
        arm/vpx_convolve_copy_neon.c
        arm/vpx_convolve8_neon.c
        arm/vpx_convolve_avg_neon.c
        arm/vpx_convolve_neon.c
      )
    endif()
  else(HAVE_NEON_ASM)
    if (HAVE_NEON)
    LIST(APPEND vpx_dsp_srcs
        arm/loopfilter_neon.c
        arm/idct8x8_1_add_neon.c
        arm/idct8x8_add_neon.c
        arm/idct16x16_1_add_neon.c
        arm/idct16x16_add_neon.c
        arm/idct32x32_1_add_neon.c
        arm/idct32x32_34_add_neon.c
        arm/idct32x32_135_add_neon.c
        arm/idct32x32_add_neon.c
      )
    endif()
  endif()

  if (HAVE_MSA)
    LIST(APPEND vpx_dsp_srcs
      mips/vpx_convolve8_avg_horiz_msa.c
      mips/vpx_convolve8_avg_msa.c
      mips/vpx_convolve8_avg_vert_msa.c
      mips/vpx_convolve8_horiz_msa.c
      mips/vpx_convolve8_msa.c
      mips/vpx_convolve8_vert_msa.c
      mips/vpx_convolve_avg_msa.c
      mips/vpx_convolve_copy_msa.c

      mips/loopfilter_16_msa.c
      mips/loopfilter_8_msa.c
      mips/loopfilter_4_msa.c
    )
  endif()

  if (HAVE_MMI)
    LIST(APPEND vpx_dsp_srcs
      mips/vpx_convolve8_mmi.c
    )
  endif()

  if (HAVE_DSPR2)
    LIST(APPEND vpx_dsp_srcs
      mips/convolve2_avg_dspr2.c
      mips/convolve2_avg_horiz_dspr2.c
      mips/convolve2_dspr2.c
      mips/convolve2_horiz_dspr2.c
      mips/convolve2_vert_dspr2.c
      mips/convolve8_avg_dspr2.c
      mips/convolve8_avg_horiz_dspr2.c
      mips/convolve8_dspr2.c
      mips/convolve8_horiz_dspr2.c
      mips/convolve8_vert_dspr2.c

      mips/loopfilter_filters_dspr2.c
      mips/loopfilter_mb_dspr2.c
      mips/loopfilter_mb_horiz_dspr2.c
      mips/loopfilter_mb_vert_dspr2.c
    )
  endif()

  if (HAVE_VSX)
    LIST(APPEND vpx_dsp_srcs
      ppc/vpx_convolve_vsx.c
      ppc/inv_txfm_vsx.c
    )
  endif()

  if (HAVE_LSX)
    LIST(APPEND vpx_dsp_srcs
      loongarch/vpx_convolve8_avg_horiz_lsx.c
      loongarch/vpx_convolve8_avg_vert_lsx.c
      loongarch/vpx_convolve8_horiz_lsx.c
      loongarch/vpx_convolve8_vert_lsx.c
      loongarch/vpx_convolve8_lsx.c
      loongarch/vpx_convolve8_avg_lsx.c
      loongarch/vpx_convolve_avg_lsx.c
      loongarch/vpx_convolve_copy_lsx.c

      loongarch/loopfilter_16_lsx.c
      loongarch/loopfilter_8_lsx.c
      loongarch/loopfilter_4_lsx.c
    )
  endif()

endif()

if (CONFIG_VP9_ENCODER) 
  LIST(APPEND vpx_dsp_srcs
    fwd_txfm.c
    quantize.c
  )

  if (HAVE_SSE2)
    LIST(APPEND vpx_dsp_srcs
      x86/fwd_txfm_sse2.c
      x86/quantize_sse2.c
      avg.c
    )
  endif()

  if (HAVE_SSE2)
    LIST(APPEND vpx_dsp_srcs
      x86/quantize_ssse3.c
      x86/avg_intrin_sse2.c
    )
  endif()

  if (HAVE_AVX)
    LIST(APPEND vpx_dsp_srcs
      x86/quantize_avx.c
      x86/avg_intrin_avx2.c
    )
  endif()  

  if (HAVE_AVX2)
    LIST(APPEND vpx_dsp_srcs
      x86/quantize_avx2.c
    )
  endif()  

  if (HAVE_NEON)
    LIST(APPEND vpx_dsp_srcs
      arm/fdct4x4_neon.c
      arm/fdct8x8_neon.c
      arm/fdct16x16_neon.c
      arm/fdct32x32_neon.c
      arm/fdct_partial_neon.c
      arm/quantize_neon.c
      arm/avg_neon.c
      arm/hadamard_neon.c      
    )
  endif()

  if (HAVE_MSA)
    LIST(APPEND vpx_dsp_srcs
      mips/fwd_txfm_msa.c
      mips/avg_msa.c
    )
  endif()

  if (HAVE_VSX)
    LIST(APPEND vpx_dsp_srcs
      ppc/quantize_vsx.c
    )
  endif()  

  if (HAVE_LSX)
    LIST(APPEND vpx_dsp_srcs
      loongarch/fwd_txfm_lsx.c
      loongarch/quantize_lsx.c
      loongarch/avg_lsx.c
    )
  endif()

  if (CONFIG_VP9_HIGHBITDEPTH)
    if (HAVE_SSE2)
      LIST(APPEND vpx_dsp_srcs
        x86/highbd_quantize_intrin_sse2.c
      )
    endif()

    if (HAVE_AVX2)
      LIST(APPEND vpx_dsp_srcs
        x86/fwd_txfm_avx2.c
        x86/highbd_quantize_intrin_avx2.c
      )
    endif()

    if (HAVE_NEON)
      LIST(APPEND vpx_dsp_srcs
        arm/highbd_quantize_neon.c
      )
    endif()

    if (HAVE_MSA)
      LIST(APPEND vpx_dsp_srcs
        mips/fwd_dct32x32_msa.c

        mips/idct4x4_msa.c
        mips/idct8x8_msa.c
        mips/idct16x16_msa.c
        mips/idct32x32_msa.c        
      )
    endif()    

    if (HAVE_LSX)
      LIST(APPEND vpx_dsp_srcs
        loongarch/fwd_dct32x32_lsx.c
      )
    endif()
  endif()

  if(VPX_ARCH_X86_64)
    if (HAVE_VSX)
      LIST(APPEND vpx_dsp_srcs
        ppc/hadamard_vsx.c
      )
    endif()  
  endif()
endif()

if (NOT (CONFIG_ENCODERS OR CONFIG_POSTPROC OR CONFIG_VP9_POSTPROC))
  LIST(APPEND vpx_dsp_srcs
    variance.c
  )

  if (HAVE_NEON)
    LIST(APPEND vpx_dsp_srcs
      arm/avg_pred_neon.c
      arm/subpel_variance_neon.c
      arm/variance_neon.c
    )
  endif()

  if (HAVE_MSA)
    LIST(APPEND vpx_dsp_srcs
      mips/variance_msa.c
      mips/sub_pixel_variance_msa.c
    )
  endif()
  
  if (HAVE_MMI)
    LIST(APPEND vpx_dsp_srcs
      mips/variance_mmi.c
    )
  endif()

  if (HAVE_SSE2)
    LIST(APPEND vpx_dsp_srcs
      x86/avg_pred_sse2.c
      x86/variance_sse2.c  # Contains SSE2 and SSSE3
    )
  endif() 
  
  if (HAVE_MMI)
    LIST(APPEND vpx_dsp_srcs
    x86/variance_avx2.c
    )
  endif()  

  if (HAVE_VSX)
    LIST(APPEND vpx_dsp_srcs
      ppc/variance_vsx.c
    )
  endif()  

  if (HAVE_LSX)
    LIST(APPEND vpx_dsp_srcs
      loongarch/variance_lsx.c
      loongarch/sub_pixel_variance_lsx.c
      loongarch/avg_pred_lsx.c
    )
  endif()   

  if (CONFIG_VP9_HIGHBITDEPTH)
    if (HAVE_SSE2)
      LIST(APPEND vpx_dsp_srcs
        x86/highbd_variance_sse2.c
      )
    endif()
    
    if (HAVE_NEON)
      LIST(APPEND vpx_dsp_srcs
        arm/highbd_avg_pred_neon.c
        arm/highbd_variance_neon.c
        arm/highbd_subpel_variance_neon.c
      )
    endif()

  endif()
endif()

list(REMOVE_DUPLICATES vpx_dsp_srcs)

# message(VAR(vpx_dsp) .vpx_dsp_srcs : ${vpx_dsp_srcs})

IF( vpx_dsp_srcs )
  add_library(vpx_dsp_aux1 OBJECT ${vpx_dsp_srcs})
  
  target_include_directories(vpx_dsp_aux1 
    PUBLIC ${LIBVPX_ROOT_DIR})

  target_link_libraries(vpx_dsp vpx_dsp_aux1)
ENDIF()

LIST(APPEND VPX_MODULES vpx_dsp)
