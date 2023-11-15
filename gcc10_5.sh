#!/bin/bash
set -e

# 定义GCC版本和安装路径
GCC_VERSION="gcc-10.5"
GCC_PREFIX="/usr/local/gcc-10.5"

# 下载源代码
echo "Downloading GCC source..."
wget http://ftp.gnu.org/gnu/gcc/${GCC_VERSION}/${GCC_VERSION}.tar.xz

# 解压文件
echo "Extracting GCC source..."
tar xvf ${GCC_VERSION}.tar.xz

# 进入GCC源码目录
cd ${GCC_VERSION}

# 下载前置依赖
echo "Downloading prerequisites..."
./contrib/download_prerequisites

# 返回上级目录并创建构建目录
cd ..
BUILD_DIR="temp_gcc10.5"
echo "Creating build directory ${BUILD_DIR}..."
mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}

# 配置安装选项
echo "Configuring GCC build..."
../${GCC_VERSION}/configure --prefix=${GCC_PREFIX} --enable-threads=posix --disable-checking --disable-multilib

# 编译
echo "Compiling GCC... This may take a long time."
make -j$(nproc)

# 安装
echo "Installing GCC..."
sudo make install

# 创建GCC命令的软链接
echo "Creating symlink..."
sudo ln -s ${GCC_PREFIX}/bin/gcc /usr/bin/gcc10

echo "GCC 10.5 installation completed successfully."
