#ifndef _PRINT_SUB_PARAMETERS_HEADER_H_
#define _PRINT_SUB_PARAMETERS_HEADER_H_

#include <libavcodec/avcodec.h>
#include "StringCache.h"

void print_sub_parameters(
  StringCache* sc,
  AVCodecParameters* par);

#endif
