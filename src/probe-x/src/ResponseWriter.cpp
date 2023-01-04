#include "ResponseWriter.hpp"

void writeTo(CompactResponse* dst, StringCache* src);

void ResponseWriter_init(ResponseWriter* writer) {
  writer->sc = new StringCache();
  StringCache_init(writer->sc, sizeof(char), 2048);
  writer->response = new CompactResponse();
}

void ResponseWriter_submit(ResponseWriter* writer) {
  writeTo(writer->response, writer->sc);
}

void ResponseWriter_free(ResponseWriter* writer) {
  StringCache_free(writer->sc);
  delete writer->sc;
  writer->sc = NULL;
  // delete writer->response;
  // writer->response = NULL;
}

void writeTo(CompactResponse* dst, StringCache* src) {
  // reset
  dst->packets.push_back(std::string(src->buf));
  src->offset = 0;
}