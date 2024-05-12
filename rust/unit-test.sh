#!/bin/bash
VERSION=$1
mkdir -p target/unittest.libbdk.$VERSION
cargo build --release
OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    cp target/release/libbdk_dart.so target/unittest.libbdk.$VERSION
elif [ "$OS" = "Darwin" ]; then
    cp target/release/libbdk_dart.dylib target/unittest.libbdk.$VERSION
else
    echo "Unsupported OS: $OS"
    exit 1
fi
