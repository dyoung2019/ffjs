#ifndef _INIT_DECODER_CONTEXT_HEADER_H_
#define _INIT_DECODER_CONTEXT_HEADER_H_

#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>

AVCodecContext* init_decoder_context(AVFormatContext *context, AVStream* src);

#endif