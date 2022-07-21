#!/bin/bash
set -ex

mkdir build
cd build

# full list of formats as of:
# https://github.com/libsdl-org/SDL_image/blob/release-2.6.0/CMakeLists.txt#L63-L79
# disabled JXL because it's not yet in conda-forge
cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DSDL2IMAGE_DEPS_SHARED=ON \
    -DSDL2IMAGE_VENDORED=OFF \
    -DSDL2IMAGE_AVIF=ON \
    -DSDL2IMAGE_BMP=ON \
    -DSDL2IMAGE_GIF=ON \
    -DSDL2IMAGE_JPG=ON \
    -DSDL2IMAGE_JPG_SAVE=ON \
    -DSDL2IMAGE_JXL=OFF \
    -DSDL2IMAGE_LBM=ON \
    -DSDL2IMAGE_PCX=ON \
    -DSDL2IMAGE_PNG=ON \
    -DSDL2IMAGE_PNG_SAVE=ON \
    -DSDL2IMAGE_PNM=ON \
    -DSDL2IMAGE_QOI=ON \
    -DSDL2IMAGE_SVG=ON \
    -DSDL2IMAGE_TGA=ON \
    -DSDL2IMAGE_TIF=ON \
    -DSDL2IMAGE_WEBP=ON \
    -DSDL2IMAGE_XCF=ON \
    -DSDL2IMAGE_XPM=ON \
    -DSDL2IMAGE_XV=ON \
    ..

cmake --build .
cmake --install . --prefix $PREFIX
