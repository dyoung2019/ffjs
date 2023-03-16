cmake_minimum_required(VERSION 3.22)
message(VAR(vpx_ports) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

set(vpx_ports_srcs)

if (VPX_ARCH_X86) 
  if (HAVE_MMX)
    list(APPEND vpx_ports_srcs 
      emms_mmx.c
    )
  endif()
endif()

if (VPX_ARCH_ARM) 
  list(APPEND vpx_ports_srcs 
    arm_cpudetect.c
  )
endif()

if (VPX_ARCH_PPC) 
  list(APPEND vpx_ports_srcs 
    ppc_cpudetect.c
  )
endif()

if (VPX_ARCH_MIPS) 
  list(APPEND vpx_ports_srcs 
    mips_cpudetect.c
  )
endif()

if (VPX_ARCH_LOONGARCH) 
  list(APPEND vpx_ports_srcs 
    loongarch_cpudetect.c
  )
endif()

list(REMOVE_DUPLICATES vpx_ports_srcs)

IF( vpx_ports_srcs )
  add_library(vpx_ports OBJECT ${vpx_ports_srcs})
  
  target_include_directories(vpx_ports 
    PUBLIC ${LIBVPX_ROOT_DIR}
  )

  target_link_libraries(libvpx PRIVATE vpx_ports)
ENDIF()


