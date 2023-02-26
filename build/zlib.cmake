cmake_minimum_required(VERSION 3.22)

message(VAR(zlib) .MAXIMUM_MEMORY : ${MAXIMUM_MEMORY})

add_subdirectory("./zlib")
target_compile_definitions(zlib PUBLIC BUILD_SHARED_LIBS=OFF)
target_compile_definitions(zlib PUBLIC SKIP_INSTALL_FILES=ON)
target_compile_definitions(zlib PUBLIC SKIP_INSTALL_FILES=ON)
# target_compile_options(zlib PRIVATE -Wno-dev)
target_include_directories(zlib INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/zlib)

list(APPEND EXTRA_LIBS zlib)