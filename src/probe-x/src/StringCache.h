#ifndef _STRING_CACHE_HEADER_H_
#define _STRING_CACHE_HEADER_H_

#include <stddef.h>

typedef struct StringCache {
  size_t charSize;
  char* buf;
  int capacity;
  int offset;
} StringCache;

void StringCache_init(StringCache* sc, size_t charSize, int bufferSize);
int StringCache_append(StringCache* sc, const char* fmt, ...);
int StringCache_extend(StringCache* sc, int newSize);
int StringCache_free(StringCache* sc);

#endif