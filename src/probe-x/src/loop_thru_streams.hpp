#ifndef _LOOP_THRU_STREAMS_HEADER_H_
#define _LOOP_THRU_STREAMS_HEADER_H_

extern "C" {
#include <libavformat/avformat.h>
};

#include "ResponseWriter.hpp"

void loop_thru_streams(ResponseWriter* writer, AVFormatContext *formatCtx);

#endif