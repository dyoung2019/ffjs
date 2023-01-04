#include "probe_video_file.hpp"
#include <algorithm>
#include <iostream>

void print_fn(std::string& s) {
  std::cout << s << std::endl;
}

void debugResponse(CompactResponse* res) {
    for_each(res->packets.begin(), res->packets.end(), print_fn);
}

int main(int argc, char** argv) {
  const char* inputFile = NULL;

  if (argc != 2) {
    printf("Usage: %s <path_to_video_file>\n", argv[0]);
    return -1;
  }
  inputFile = argv[0];

  CompactResponse* result = probe_video_file(inputFile);
  if (result) {
    printf("VIDEO LOADED\n");
    debugResponse(result);
    delete result;
    return 0;
  } 
  else {
    return -1;
  }
  return 0;
}