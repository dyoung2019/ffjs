#ifndef _PRINT_UTILS_HEADER_FILE_H_
#define _PRINT_UTILS_HEADER_FILE_H_

#include <libavformat/avformat.h>
#include "StringCache.h"

void print_q(StringCache* sc, const char* key, AVRational value, char sep);
void print_int(StringCache* sc, const char* key, int value);
void print_str(StringCache* sc, const char* key, const char* value);
void print_value(StringCache* sc, const char* key, long long int v, const char* u);
void print_ts(StringCache *sc, const char *key, int64_t ts, int is_duration);
void print_time(StringCache *sc, const char *key,
  int64_t ts, const AVRational *time_base, int is_duration);
void print_u8_data(StringCache* sc, const char *name,
  uint8_t *data, int size);

#endif