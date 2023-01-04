#ifndef _PRINT_A_STREAM_HEADER_H_
#define _PRINT_A_STREAM_HEADER_H_

#include <libavformat/avformat.h>
#include <libavcodec/avcodec.h>
#include "StringCache.h"

void print_a_stream(
  StringCache* sc, 
  AVFormatContext* formatCtx,
  AVStream* stream,
  AVCodecContext* decoderCtx
  );

#endif