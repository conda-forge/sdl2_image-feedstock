#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .
set -ex

mkdir build
cd build

# full list of formats as of:
# https://github.com/libsdl-org/SDL_image/blob/release-2.6.0/CMakeLists.txt#L63-L79
# disabled JXL because it's not yet in conda-forge
cmake ${CMAKE_ARGS} -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
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

# For backward compatibility with old builds of sdl2_ttf that linked with strangly-named
# version of the libraries, we define some symlinks, remove once the library is updated to sdl3
if [[ "${target_platform}" == osx-* ]]; then
    cd ${PREFIX}/lib
    ln -s ./libSDL2_image-2.0.0.dylib ./libSDL2_image-2.0.801.0.0.dylib
    ln -s ./libSDL2_image-2.0.0.dylib ./libSDL2_image-2.0.601.3.0.dylib
    ln -s ./libSDL2_image-2.0.0.dylib ./libSDL2_image-2.0.601.2.0.dylib
    ln -s ./libSDL2_image-2.0.0.dylib ./libSDL2_image-2.0.601.1.0.dylib
    ln -s ./libSDL2_image-2.0.0.dylib ./libSDL2_image-2.0.601.0.0.dylib
    ln -s ./libSDL2_image-2.0.0.dylib ./libSDL2_image-2.0.3.0.0.dylib
fi
