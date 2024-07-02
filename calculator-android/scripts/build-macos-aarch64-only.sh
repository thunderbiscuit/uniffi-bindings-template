#!/bin/bash

# Set up environment variables
export PATH="${PATH}:${ANDROID_NDK_ROOT}/toolchains/llvm/prebuilt/darwin-x86_64/bin"
export CFLAGS="-D__ANDROID_MIN_SDK_VERSION__=24"
export AR="llvm-ar"
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER="aarch64-linux-android24-clang"
export CC="aarch64-linux-android24-clang"

# Move to the Rust library directory
cd ../calculator-ffi/

# Build the Rust library
cargo build --profile release-smaller --target aarch64-linux-android

# Generate Kotlin bindings using uniffi-bindgen
cargo run --release --bin uniffi-bindgen generate --library ./target/aarch64-linux-android/release-smaller/libcalculatorffi.so --language kotlin --out-dir ../calculator-android/lib/src/main/kotlin/ --no-format

# Copy the binary to the Android resources directory
cp ./target/aarch64-linux-android/release-smaller/libcalculatorffi.so ../calculator-android/lib/src/main/jniLibs/arm64-v8a/libcalculatorffi.so
