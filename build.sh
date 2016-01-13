#!/bin/sh
set -eu

mkdir -p "$WORKSPACE/build/dashel"
cd "$WORKSPACE/build/dashel"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 -D "BUILD_SHARED_LIBS=ON"\
 -D "CMAKE_OSX_ARCHITECTURES=i386;x86_64"
 -D "CMAKE_OSX_DEPLOYMENT_TARGET=10.6"
 -D "CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.6.sdk"
 "$WORKSPACE/source/dashel"
make

mkdir -p "$WORKSPACE/build/enki"
cd "$WORKSPACE/build/enki"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 "$WORKSPACE/source/enki"
make

mkdir -p "$WORKSPACE/build/aseba"
cd "$WORKSPACE/build/aseba"
cmake\
 -D "dashel_DIR=$WORKSPACE\build\dashel"\
 -D "DASHEL_INCLUDE_DIR=$WORKSPACE/source/dashel"\
 -D "DASHEL_LIBRARY=$WORKSPACE/build/dashel/libdashel.a"\
 "$WORKSPACE/source/aseba"
make

cd "$WORKSPACE"
env
touch fanny.pkg
