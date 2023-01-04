#include "StringCache.h"

#include <libavutil/avstring.h>
#include <libavutil/mem.h> 

// fn declarations
void StringCache_increase_capacity(StringCache* sc, int expectedSize);
int StringCache_format(StringCache* sc, const char* fmt, va_list args);
char* StringCache_get_array_start(StringCache* sc);
int StringCache_get_bounds(StringCache* sc);
int StringCache_get_estimate(StringCache* sc, int estimate);
int StringCache_on_text_added(StringCache* sc, int result);
int StringCache_is_redo_required(int expectedSize);

// local implementations

void StringCache_increase_capacity(StringCache* sc, int expectedSize) {
  // EXTEND
  int doubleCapacity = sc->capacity * 2;
  int finalCapacity = expectedSize > doubleCapacity
    ? expectedSize
    : doubleCapacity;
  StringCache_extend(sc, finalCapacity);
}

int StringCache_format(StringCache* sc, const char* fmt, va_list args) {
  char* start = StringCache_get_array_start(sc);
  int bounds = StringCache_get_bounds(sc);
  return vsnprintf(start, bounds, fmt, args);
}

char* StringCache_get_array_start(StringCache* sc) {
  return sc->buf + sc->offset;
}

int StringCache_get_bounds(StringCache* sc) {
  return sc->capacity - sc->offset;
}

int StringCache_get_estimate(StringCache* sc, int estimate) {
  return sc->charSize * estimate + sc->offset;
}

int StringCache_on_text_added(StringCache* sc, int result) {
  int expectedSize = StringCache_get_estimate(sc, result);
  if (expectedSize < sc->capacity) {
    sc->offset = expectedSize;
    return 0;
  } else {
    return expectedSize;
  }
}

int StringCache_is_redo_required(int expectedSize) {
  return (expectedSize != 0);
}

// global fns

void StringCache_init(StringCache* sc, size_t charSize, int bufferSize) {
  sc->charSize = charSize;
  sc->capacity = bufferSize;
  sc->offset = 0;
  sc->buf = (char*) av_realloc(NULL, sc->charSize * sc->capacity);
}

int StringCache_extend(StringCache* sc, int newSize) {
  sc->capacity = sc->charSize * newSize;
  return av_reallocp(&sc->buf, sc->capacity);
}

int StringCache_append(StringCache* sc, const char* fmt, ...) {
  va_list va;
  int result;

  va_start(va, fmt);
  result = StringCache_format(sc, fmt, va);
  va_end(va);

  int expectedSize = StringCache_on_text_added(sc, result);
  if (StringCache_is_redo_required(expectedSize)) {
    StringCache_increase_capacity(sc, expectedSize);

    va_start(va, fmt);
    result = StringCache_format(sc, fmt, va);
    va_end(va);

    return StringCache_on_text_added(sc, result);
  } else {
    return 0; // SUCCESS
  }

}

int StringCache_free(StringCache* sc) {
  // FREE
  // sc->packets.clear();
  return av_reallocp(&sc->buf, 0);
}
