#!/bin/bash

if [ -z "$NDK" ]
then
    echo "NDK path not set"
fi

if [ -z "$1" ]
then
    echo "TARGET_ARCH not set"
fi

TARGET_ARCH="$1"
API_LEVEL="21"

if [ "$TARGET_ARCH" == "arm64-v8a" ]
then
    TARGET="aarch64-linux-android"
elif [ "$TARGET_ARCH" == "armeabi-v7a" ]
then
    TARGET="arm-linux-androideabi"
elif [ "$TARGET_ARCH" == "x86_64" ]
then
    TARGET="x86_64-linux-android"
elif [ "$TARGET_ARCH" == "x86" ]
then
    TARGET="i686-linux-android"
fi

TOOLCHAINS="$NDK/toolchains/$TARGET-4.9/prebuilt/linux-x86_64/bin"

# 如果 TARGET_ARCH 为 x86 或 x86_64, 则使用特定的路径
if [ "$TARGET_ARCH" == "x86" ]
then
    TOOLCHAINS="$NDK/toolchains/x86-4.9/prebuilt/linux-x86_64/bin"
elif [ "$TARGET_ARCH" == "x86_64" ]
then
    TOOLCHAINS="$NDK/toolchains/x86_64-4.9/prebuilt/linux-x86_64/bin"
fi

# 根据 TARGET_ARCH 设置 sysroot
if [ "$TARGET_ARCH" == "arm64-v8a" ]
then
    SYSROOT="$NDK/platforms/android-$API_LEVEL/arch-arm64"
elif [ "$TARGET_ARCH" == "armeabi-v7a" ]
then
	SYSROOT="$NDK/platforms/android-$API_LEVEL/arch-arm"
elif [ "$TARGET_ARCH" == "x86_64" ]
then
    SYSROOT="$NDK/platforms/android-$API_LEVEL/arch-x86_64"
elif [ "$TARGET_ARCH" == "x86" ]
then
	SYSROOT="$NDK/platforms/android-$API_LEVEL/arch-x86"
fi

# 编译参数
CC="$TOOLCHAINS/$TARGET-gcc"
CXX="$TOOLCHAINS/$TARGET-g++"
LD="$TOOLCHAINS/$TARGET-ld"
CFLAGS="-I$NDK/sysroot/usr/include/$TARGET -I$NDK/sources/cxx-stl/llvm-libc++/include -I$NDK/sysroot/usr/include"
LDFLAGS="--sysroot=$SYSROOT"
SOURCE_DIR="$(pwd)"
BUILD_OUTPUT_DIR="$SOURCE_DIR/build/$TARGET_ARCH"

# 如果为 TARGET_ARCH 为 armeabi-v7a, 则添加另外的参数
if [ "$TARGET_ARCH" == "armeabi-v7a" ]
then
	CFLAGS="$CFLAGS -mfloat-abi=softfp -mfpu=neon"
fi

echo "C Compiler is:   $CC"
echo "C++ Compiler is: $CXX"
echo "ld is:           $LD"
echo "CFLAGS:          $CFLAGS"
echo "LDFLAGS:         $LDFLAGS"
echo "SOURCE_DIR:      $SOURCE_DIR"
echo "BUILD_OUTPUT_DIR:$BUILD_OUTPUT_DIR"

cd "CPP/7zip/Bundles/Format7zF" || { ehco "CPP/7zip/Bundles/Format7zF directory not found"; }
make -f makefile.gcc clean
make -f makefile.gcc CC="$CC" CXX="$CXX" LD="$LD" CFLAGS_ANDROID_NDK="$CFLAGS" LDFLAGS_ANDROID_NDK="$LDFLAGS"

if [ ! -d "$BUILD_OUTPUT_DIR" ];then
  mkdir "$BUILD_OUTPUT_DIR" -p
fi

mv _o/7z.so "$BUILD_OUTPUT_DIR/lib7z.so"

cd "$SOURCE_DIR" || { ehco "Source directory not found"; }
