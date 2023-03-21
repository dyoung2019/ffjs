cmake_minimum_required(VERSION 3.22)
message(VAR(lame-mpglib) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

add_library(lame-mpglib OBJECT
  common.c
	dct64_i386.c
	decode_i386.c
	interface.c
	layer1.c
	layer2.c
	layer3.c
	tabinit.c
)

target_include_directories(
  lame-mpglib PUBLIC 
  ${LAME_ROOT_DIR}
  ${LAME_INCLUDE_DIR}
  ${LAME_LIBMP3LAME_DIR}
)

target_compile_definitions(lame-mpglib PUBLIC HAVE_MEMCPY)
target_compile_definitions(lame-mpglib PUBLIC HAVE_CONFIG_H)