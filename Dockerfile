FROM emscripten/emsdk:3.1.28 as build

RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|mirror://mirrors.ubuntu.com/mirrors.txt|g' /etc/apt/sources.list \
 && apt-get update && apt-get install -y git build-essential automake libtool pkg-config cmake && apt-get clean

COPY ./CMakeLists.txt /build/CMakeLists.txt 
COPY ./emscripten /build/emscripten
COPY ./src /build/src
COPY ./build /build/build

ENV EMSCRIPTEN /emsdk/upstream/emscripten/

WORKDIR /build

RUN cmake -DCMAKE_TOOLCHAIN_FILE=/build/emscripten/cmake/Modules/Platform/Emscripten.cmake \
  -G "Unix Makefiles" .

RUN make all