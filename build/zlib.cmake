cmake_minimum_required(VERSION 3.22)

message(VAR(zlib) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

add_subdirectory("./zlib")
target_compile_definitions(zlib PUBLIC BUILD_SHARED_LIBS=ON)
target_compile_definitions(zlib PUBLIC SKIP_INSTALL_FILES=ON)
target_compile_definitions(zlib PUBLIC SKIP_INSTALL_FILES=ON)
target_compile_options(zlib PRIVATE -Wno-dev)

list(APPEND EXTRA_LIBS zlib)