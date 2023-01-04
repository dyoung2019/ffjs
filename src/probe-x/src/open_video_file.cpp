#include "open_video_file.hpp"
#include "loop_thru_streams.hpp"
#include "ResponseWriter.hpp"

extern "C" {
#include "print_video_format.h"
};

// fn declarations
int open_file_and_read_header(AVFormatContext** contextPtr, const char* inputFilePath);
int get_stream_info_from_format(AVFormatContext* context);

CompactResponse* open_video_file(AVFormatContext* context, const char* inputFilePath) {
  int hasError = open_file_and_read_header(&context, inputFilePath);
  if (hasError) {
    return NULL;
  }

  hasError = get_stream_info_from_format(context);
  if (hasError) {
    // printf("ERROR: could not get stream info\n");
    return NULL;
  }

  ResponseWriter writer;
  ResponseWriter_init(&writer);
  print_video_format(writer.sc, context);
  ResponseWriter_submit(&writer);

  loop_thru_streams(&writer, context);

  ResponseWriter_free(&writer);

  return writer.response;
}

int open_file_and_read_header(AVFormatContext** contextPtr, const char* inputFilePath) {
  int ret = avformat_open_input(contextPtr, inputFilePath, NULL, NULL); 

  if (ret < 0) {
    printf("ERROR: %s\n", av_err2str(ret));
    return -1;
  }
  else {
    return 0;
  }
}

int get_stream_info_from_format(AVFormatContext* context) {
  return (avformat_find_stream_info(context, NULL) < 0);
}