#!/usr/bash
cmake -DCMAKE_TOOLCHAIN_FILE=./emscripten/cmake/Modules/Platform/Emscripten.cmake -DEMSCRIPTEN_ROOT_PATH=/usr/local/opt/emscripten/bin/ .
