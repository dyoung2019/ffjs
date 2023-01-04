
SUBDIRS=src
foo-local:
	@echo This will be run by "make foo".

# custom makefile
ECC=emcc
EXX=em++
MAX_FILE_SIZE=33554432
EFLAGS=-O3 -s INITIAL_MEMORY=$(MAX_FILE_SIZE) -s EXTRA_EXPORTED_RUNTIME_METHODS="[FS, cwrap, ccall, getValue, setValue, writeAsciiToMemory]"
ECCFLAGS=-$(EFLAGS) -bind
EXXFLAGS=-$(EFLAGS) -bind
ELDFLAGS=-lavcodec -lavformat -lavutil -lx264 -lworkerfs.js

OPT_PATH=/usr/local/opt/
INCLUDE_FLAGS=-I$(OPT_PATH)ffmpeg/include/
FFMPEG_PREFIX=$(OPT_PATH)ffmpeg
FFMPEG_LIB_PATH=$(FFMPEG_PREFIX)/lib/

LDFLAGS= \
	$(FFMPEG_LIB_PATH)libavformat.dylib \
	$(FFMPEG_LIB_PATH)libavcodec.dylib \
	$(FFMPEG_LIB_PATH)libavutil.dylib

BUILD_OBJECTS= \
	build-ecc/free_decoder_context.o \
	build-ecc/init_decoder_context.o \
	build-exx/loop_thru_streams.o \
	build-exx/main.o \
	build-exx/open_video_file.o \
	build-ecc/print_a_stream.o \
	build-ecc/print_audio_parameters.o \
	build-ecc/print_disposition_info.o \
	build-ecc/print_stream_parameters.o \
	build-ecc/print_sub_parameters.o \
	build-ecc/print_tags_dictionary.o \
	build-ecc/print_utils.o \
	build-ecc/print_video_format.o \
	build-ecc/print_video_parameters.o \
	build-exx/probe_video_file.o \
	build-exx/ResponseWriter.o \
	build-ecc/StringCache.o \
	build-ecc/utils.o

build-ecc:
	mkdir -p build-ecc
	mkdir -p build-exx

dist-emcc:
	mkdir -p dist-emcc

# probex: build $(BUILD_OBJECTS)
# 	$(CXX) \
# 	$(LDFLAGS) \
# 	-o $@ \
# 	$(LDFLAGS) \
# 	$(BUILD_OBJECTS)

probe-x.mjs: dist-emcc $(BUILD_OBJECTS)
	$(EXX) $(ELDFLAGS) -o dist-emcc/probe-x.mjs $(BUILD_OBJECTS)

probe-x.js: dist-emcc $(BUILD_OBJECTS)
	$(EXX) $(ELDFLAGS) -o dist-emcc/probe-x.js $(BUILD_OBJECTS)

build-exx/%.o: build-ecc src/%.cpp
	$(EXX) $(EXXFLAGS) -O -c $< $(INCLUDE_FLAGS) -o $@

build-ecc/%.o: build-ecc src/%.c
	$(ECC) $(ECCFLAGS) -O -c $< $(INCLUDE_FLAGS) -o $@



# probex-clean:
# 	rm -r build

  
	