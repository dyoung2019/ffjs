// quick_example.cpp
#include <emscripten/bind.h>
#include <vector>
#include <string>

using namespace emscripten;

std::vector<std::string> probe_x(std::string filename) {
  std::vector<std::string> output;
  output.push_back("hello=2|world=3");
  output.push_back(filename);
  output.push_back("stream|world=3");
  return output;
}

EMSCRIPTEN_BINDINGS(my_module) {
  function("probe_x", &probe_x);

  register_vector<std::string>("vector<string>");
}