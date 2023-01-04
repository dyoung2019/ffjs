#ifndef _PRINT_VIDEO_PARAMETERS_HEADER_FILE_H_
#define _PRINT_VIDEO_PARAMETERS_HEADER_FILE_H_

#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>

#include "StringCache.h"

void print_video_parameters(
  StringCache* sc,
  AVCodecParameters *par,
  AVFormatContext *formatCtx,
  AVStream *stream,
  AVCodecContext* decoderCtx);

#endif