#ifndef _OPEN_VIDEO_FILE_HEADER_H_
#define _OPEN_VIDEO_FILE_HEADER_H_

extern "C" {
#include <libavformat/avformat.h>
};
#include "CompactResponse.hpp"

CompactResponse* open_video_file(AVFormatContext* context, const char* inputFilePath);

#endif
