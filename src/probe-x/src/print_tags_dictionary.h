#ifndef _PRINT_TAGS_DICTIONARY_HEADER_H_
#define _PRINT_TAGS_DICTIONARY_HEADER_H_

#include <libavutil/dict.h>
#include "StringCache.h"

void print_tags_dictionary(
  StringCache* writer, 
  AVDictionary *tags, 
  const char* prefix);

#endif