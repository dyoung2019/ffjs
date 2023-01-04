#ifndef _PRINT_STREAM_PARAMETERS_HEADER_FILE_
#define _PRINT_STREAM_PARAMETERS_HEADER_FILE_

#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include "StringCache.h"

void print_stream_parameters(
  StringCache* sc, 
  AVCodecParameters *par, 
  AVStream* stream,
  AVCodecContext* decoderCtx);

#endif
