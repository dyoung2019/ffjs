#include "loop_thru_streams.hpp"

extern "C" {
#include "print_a_stream.h"
#include "init_decoder_context.h"
#include "free_decoder_context.h"
}

void loop_thru_streams(ResponseWriter* writer, AVFormatContext *formatCtx) {
  // Loop through the streams.
  for (int i = 0; i < formatCtx->nb_streams; i++) {
    AVStream *stream = formatCtx->streams[i];

    AVCodecContext *decoderCtx = init_decoder_context(formatCtx, stream);
    print_a_stream(writer->sc, formatCtx, stream, decoderCtx);
    free_decoder_context(&decoderCtx);
    ResponseWriter_submit(writer);
  }
}
