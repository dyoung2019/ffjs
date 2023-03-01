set(extra_srcs)

if (VPX_ARCH_X86) 
  if (HAVE_MMX)
    list(APPEND extra_srcs 
      emms_mmx.c
    )
  endif()
endif()

if (VPX_ARCH_ARM) 
  list(APPEND extra_srcs 
    arm_cpudetect.c
  )
endif()

if (VPX_ARCH_PPC) 
  list(APPEND extra_srcs 
    ppc_cpudetect.c
  )
endif()

if (VPX_ARCH_MIPS) 
  list(APPEND extra_srcs 
    mips_cpudetect.c
  )
endif()

if (VPX_ARCH_LOONGARCH) 
  list(APPEND extra_srcs 
    loongarch_cpudetect.c
  )
endif()

list(REMOVE_DUPLICATES extra_srcs)

IF( extra_srcs )
  add_library(vpx_ports OBJECT ${extra_srcs})
  
  target_include_directories(vpx_ports 
    PUBLIC ${LIBVPX_ROOT_DIR}
  )

  LIST(APPEND VPX_MODULES vpx_ports)
ENDIF()


