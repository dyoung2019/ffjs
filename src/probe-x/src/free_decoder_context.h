#ifndef _FREE_DECODER_CONTEXT_HEADER_H_
#define _FREE_DECODER_CONTEXT_HEADER_H_

#include <libavcodec/avcodec.h>

void free_decoder_context(AVCodecContext** context);

#endif