#ifndef _PRINT_VIDEO_FORMAT_HEADER_H_
#define _PRINT_VIDEO_FORMAT_HEADER_H_

#include <libavformat/avformat.h>
#include "StringCache.h"

void print_video_format(StringCache* sc, AVFormatContext* context);

#endif