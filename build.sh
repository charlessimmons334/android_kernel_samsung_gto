#!/bin/bash

export ARCH=arm64
export SUBARCH=arm64

KERNEL_DIR=$(pwd)
OUT_DIR="$KERNEL_DIR/out"
DEFCONFIG="P81081_msm8937_defconfig"

CLANG_DIR="/opt/toolchains/clang"
GCC64="/opt/toolchains/gcc64"
GCC32="/opt/toolchains/gcc32"

export CROSS_COMPILE="$GCC64/bin/aarch64-linux-android-"
export CROSS_COMPILE_ARM32="$GCC32/bin/arm-linux-androideabi-"
export CLANG_TRIPLE=aarch64-linux-gnu-
export PATH="$CLANG_DIR/bin:$PATH"

chmod +x defconfig-patch.sh
./defconfig-patch.sh

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

make O="$OUT_DIR" $DEFCONFIG

make -j$(nproc) O="$OUT_DIR" \
    CC=clang \
    CLANG_TRIPLE=$CLANG_TRIPLE \
    CROSS_COMPILE=$CROSS_COMPILE \
    CROSS_COMPILE_ARM32=$CROSS_COMPILE_ARM32 \
    DTC_EXT=$KERNEL_DIR/tools/dtc \
    CONFIG_BUILD_ARM64_DT_OVERLAY=y \
    KCFLAGS=-mno-android

cp "$OUT_DIR/arch/arm64/boot/Image" "$KERNEL_DIR/Image"
echo "✅ Kernel build complete. Output: $KERNEL_DIR/Image"