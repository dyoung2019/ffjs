#ifndef _PRINT_DISPOSITION_INFO_HEADER_H_
#define _PRINT_DISPOSITION_INFO_HEADER_H_

// #include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>
#include "StringCache.h"

void print_disposition_info(StringCache* sc, AVStream* stream);

#endif
