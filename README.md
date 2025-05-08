# Kernel Build Instructions (Clang/Docker)

## 🔧 Build in Docker
```bash
docker build -t gto-kernel .
docker run -it --rm -v $PWD:/kernel gto-kernel bash
```

## 🏗️ Inside Docker
```bash
cd /kernel
./build.sh
```

This builds the Image with Clang r416183b and applies performance patches.