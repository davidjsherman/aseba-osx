#!/bin/sh
echo QWT PATH is ${your_qwt_path:='/usr/local/qwt-6.1.2'}
echo MACOSX_SDK is ${MACOSX_SDK:='MacOSX10.11.sdk'}
set -eu

[ -d "$WORKSPACE/source" -o -L "$WORKSPACE/source" ] || ln -s . "$WORKSPACE/source"

mkdir -p "$WORKSPACE/build/dashel"
cd "$WORKSPACE/build/dashel"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 -D "BUILD_SHARED_LIBS=ON"\
 -D "CMAKE_OSX_ARCHITECTURES=i386;x86_64"\
 -D "CMAKE_OSX_DEPLOYMENT_TARGET=10.9"\
 -D "CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/$MACOSX_SDK"\
 "$WORKSPACE/source/dashel"
make

mkdir -p "$WORKSPACE/build/enki"
cd "$WORKSPACE/build/enki"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 -D "CMAKE_OSX_ARCHITECTURES=x86_64"\
 -D "CMAKE_OSX_DEPLOYMENT_TARGET=10.9"\
 -D "CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/$MACOSX_SDK"\
 "$WORKSPACE/source/enki"
make

mkdir -p "$WORKSPACE/build/aseba"
cd "$WORKSPACE/build/aseba"
cmake\
 -D "CMAKE_BUILD_TYPE=Release"\
 -D "CMAKE_OSX_ARCHITECTURES=x86_64"\
 -D "CMAKE_OSX_DEPLOYMENT_TARGET=10.9"\
 -D "CMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/$MACOSX_SDK"\
 -D "dashel_DIR=$WORKSPACE/build/dashel"\
 -D "DASHEL_INCLUDE_DIR=$WORKSPACE/source/dashel"\
 -D "DASHEL_LIBRARY=$WORKSPACE/build/dashel/libdashel.dylib"\
 -D "ENKI_INCLUDE_DIR=$WORKSPACE/source/enki"\
 -D "ENKI_LIBRARY=$WORKSPACE/build/enki/enki/libenki.a"\
 -D "ENKI_VIEWER_LIBRARY=$WORKSPACE/build/enki/viewer/libenkiviewer.a"\
 -D "QWT_INCLUDE_DIR=$your_qwt_path/lib/qwt.framework/Headers"\
 -D "QWT_LIBRARIES=$your_qwt_path/lib/qwt.framework/"\
 "$WORKSPACE/source/aseba"
make

mkdir -p "$WORKSPACE/build/packager"
cd "$WORKSPACE/build/packager"
"$WORKSPACE/source/packager/packager_script"

cd "$WORKSPACE"
env

