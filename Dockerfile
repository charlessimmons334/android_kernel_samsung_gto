FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git wget curl unzip bc bison flex build-essential \
    libssl-dev libncurses5-dev libelf-dev ccache python3 \
    ca-certificates rsync zip nano xz-utils

WORKDIR /opt/toolchains

# Download and extract public LLVM 16 toolchain
RUN wget https://releases.linaro.org/components/toolchain/clang/16.0.2/linux-x86_64/clang+llvm-16.0.2-x86_64-linux-gnu.tar.xz -O clang.tar.xz && \
    mkdir clang && tar -xf clang.tar.xz -C clang --strip-components=1

# Clone AOSP GCC toolchains
RUN mkdir -p gcc64 && \
    git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 gcc64

RUN mkdir -p gcc32 && \
    git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 gcc32

ENV PATH="/opt/toolchains/clang/bin:/opt/toolchains/gcc64/bin:/opt/toolchains/gcc32/bin:$PATH"

WORKDIR /kernel