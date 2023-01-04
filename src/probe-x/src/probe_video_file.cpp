#include "probe_video_file.hpp"
#include "open_video_file.hpp"

extern "C" {
#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include <stdio.h>
};

// fn declarations
AVFormatContext* init_format_context();
void free_format_context(AVFormatContext** contextPtr);

CompactResponse* probe_video_file(const char* inputFile) {
  FILE* fp = fopen(inputFile, "rb");
  if (fp != NULL) {
    return NULL;
  }
  fclose(fp);

  AVFormatContext* context = init_format_context();
  if (!context) {
    return NULL;
  } 

  CompactResponse* result = open_video_file(context, inputFile);
  free_format_context(&context);
  return result;  
}

AVFormatContext* init_format_context() {
  return avformat_alloc_context();
}

void free_format_context(AVFormatContext** contextPtr) {
  avformat_close_input(contextPtr);
}