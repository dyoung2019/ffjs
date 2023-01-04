#include "free_decoder_context.h"

void free_decoder_context(AVCodecContext** context) {
  avcodec_free_context(context);
}