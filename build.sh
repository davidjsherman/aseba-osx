#!/bin/sh
set -eu

mkdir -p "$WORKSPACE/build/dashel"
cd "$WORKSPACE/build/dashel"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 -D "BUILD_SHARED_LIBS=ON"\
 -D "CMAKE_OSX_ARCHITECTURES=i386;x86_64"\
 -D "CMAKE_OSX_DEPLOYMENT_TARGET=10.6"\
 -D "CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk"\
 "$WORKSPACE/source/dashel"
make

mkdir -p "$WORKSPACE/build/enki"
cd "$WORKSPACE/build/enki"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 -D "CMAKE_OSX_ARCHITECTURES=x86_64"\
 -D "CMAKE_OSX_DEPLOYMENT_TARGET=10.6"\
 -D "CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk"\
 "$WORKSPACE/source/enki"
make

mkdir -p "$WORKSPACE/build/aseba"
cd "$WORKSPACE/build/aseba"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 -D "CMAKE_OSX_ARCHITECTURES=i386;x86_64"\
 -D "CMAKE_OSX_DEPLOYMENT_TARGET=10.6"\
 -D "CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk"\
 -D "dashel_DIR=$WORKSPACE/build/dashel"\
 -D "DASHEL_INCLUDE_DIR=$WORKSPACE/source/dashel"\
 -D "DASHEL_LIBRARY=$WORKSPACE/build/dashel/libdashel.dylib"\
 -D "ENKI_INCLUDE_DIR=$WORKSPACE/source/enki"\
 -D "ENKI_LIBRARY=$WORKSPACE/build/enki/libenki.a"\
 -D "ENKI_VIEWVER_LIBRARY=$WORKSPACE/build/enki/viewer/libenkiviewer.a"\
 -D "QWT_INCLUDE_DIR=$ASEBA_DEP/qwt-5.2.1/src"\
 -D "QWT_LIBRARIES=$ASEBA_DEP/qwt-5.2.1/lib/libqwt5.a"\
 -D "QT_QMAKE_EXECUTABLE=$ASEBA_DEP/qt-everywhere-opensource-src-4.8.7/bin/qmake"
 "$WORKSPACE/source/aseba"
make

cd "$WORKSPACE"
env
touch fanny.pkg
