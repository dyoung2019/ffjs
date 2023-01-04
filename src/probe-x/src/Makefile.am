foo-local:
	@echo This too will be run by a "make foo" issued either in
	@echo the 'sub/src/' directory, the 'sub/' directory, or the
	@echo top-level directory.

bin_PROGRAMS=probex
AM_CPPFLAGS=-I/usr/local/opt/ffmpeg/include/
probex_SOURCES=main.cpp \
  free_decoder_context.c \
	init_decoder_context.c \
	loop_thru_streams.cpp \
	open_video_file.cpp \
	print_a_stream.c \
	print_audio_parameters.c \
	print_disposition_info.c \
	print_stream_parameters.c \
	print_sub_parameters.c \
	print_tags_dictionary.c \
	print_utils.c \
	print_video_format.c \
	print_video_parameters.c \
	probe_video_file.cpp \
	ResponseWriter.cpp \
	utils.c \
	StringCache.c


