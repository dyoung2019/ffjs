#ifndef _RESPONSE_WRITER_HEADER_H_
#define _RESPONSE_WRITER_HEADER_H_

extern "C" {
#include "StringCache.h"
};
#include "CompactResponse.hpp"

typedef struct ResponseWriter {
  StringCache* sc;
  CompactResponse* response;
} ResponseWriter;

void ResponseWriter_init(ResponseWriter* writer);
void ResponseWriter_submit(ResponseWriter* writer);
void ResponseWriter_free(ResponseWriter* writer);

#endif