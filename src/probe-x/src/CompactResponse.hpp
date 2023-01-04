#ifndef _COMPACT_RESPONSE_HEADER_H_
#define _COMPACT_RESPONSE_HEADER_H_

#include <vector>
#include <string>

typedef struct CompactResponse {
  std::vector<std::string> packets;
} CompactResponse;

#endif
