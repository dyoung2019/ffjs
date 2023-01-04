#ifndef _PRINT_AUDIO_PARAMETERS_HEADER_H_
#define _PRINT_AUDIO_PARAMETERS_HEADER_H_

#include <libavcodec/avcodec.h>
#include "StringCache.h"

void print_audio_parameters(StringCache* sc, AVCodecParameters* par);

#endif
