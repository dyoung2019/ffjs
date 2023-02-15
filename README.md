# ffmpeg 

## TL;DNR
```bash
> cmake -DCMAKE_TOOLCHAIN_FILE=./build/emscripten/cmake/Modules/Platform/Emscripten.cmake -DCMAKE_BUILD_TYPE=Release -DEMSCRIPTEN_ROOT_PATH=/usr/local/opt/emscripten/bin/ -G "Unix Makefiles" .
> make all
```

### MACOS

````sh
emcmake cmake -G "Unix Makefiles" .
````

#### local compiliation

- -Wno-dev (disable policy warnings)
- -DLLVM_ROOT (set llvm root to emscripten custom build)

````sh
> brew install make binaryen emscripten llvm
> cmake -Wno-dev -DLLVM_ROOT=/usr/local/opt/emscripten/libexec/llvm/bin -DCMAKE_TOOLCHAIN_FILE=./build/emscripten/cmake/Modules/Platform/Emscripten.cmake  -DEMSCRIPTEN_ROOT_PATH=/usr/local/opt/emscripten/bin/ -G "Unix Makefiles" .
> make all
````

## Purpose

ffmpeg conversion to HLS 
  - via probing of file based on ffmpeg
  - conversion of file into HLS playlist and segments
  - hosted in browser 
  - probing done in web worker / WorkerFS to avoid copying / upload large files
  - outputting file to browser storage or node system

## BACKGROUND

Based on 
- ffmpeg.wasm-core
- ffmpeg.js

## LINKS

[ffmpeg compatibility](https://www.ffmpeg.org/general.html)
[cmake tips](https://syllogismobile.wordpress.com/2020/06/01/android-cmake-and-ffmpeg-part-one-cmake-in-android-cookbook/)
[cmake globs](https://stackoverflow.com/questions/8304190/cmake-with-include-and-source-paths-basic-setup)
[cmake scope](https://levelup.gitconnected.com/cmake-variable-scope-f062833581b7)