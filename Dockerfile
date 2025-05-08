FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git wget curl unzip bc bison flex build-essential \
    libssl-dev libncurses5-dev libelf-dev ccache python3 \
    ca-certificates rsync zip nano

WORKDIR /opt/toolchains

RUN curl -LO https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/master/clang-r416183b.tar.gz && \
    mkdir clang && tar -xzf clang-r416183b.tar.gz -C clang

RUN mkdir -p gcc64 && \
    git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 gcc64

RUN mkdir -p gcc32 && \
    git clone --depth=1 https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 gcc32

ENV PATH="/opt/toolchains/clang/bin:/opt/toolchains/gcc64/bin:/opt/toolchains/gcc32/bin:$PATH"

WORKDIR /kernel