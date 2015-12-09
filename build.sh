#!/bin/sh
set -eu

mkdir -p "$WORKSPACE/build/dashel"
cd "$WORKSPACE/build/dashel"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 -D "BUILD_SHARED_LIBS=OFF"\
 "$WORKSPACE/source/dashel"
make

mkdir -p "$WORKSPACE/build/enki"
cd "$WORKSPACE/build/enki"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 "$WORKSPACE/source/enki"
make

mkdir -p "$WORKSPACE/build/aseba”
cd "$WORKSPACE/build/aseba"
cmake\
 -D "dashel_DIR=$WORKSPACE\build\dashel"\
 -D "DASHEL_INCLUDE_DIR=$WORKSPACE/source/dashel"\
 -D "DASHEL_LIBRARY=$WORKSPACE/build/dashel/libdashel.a"\
 "$WORKSPACE/source/aseba"

cd "$WORKSPACE"
env
touch fanny.pkg
