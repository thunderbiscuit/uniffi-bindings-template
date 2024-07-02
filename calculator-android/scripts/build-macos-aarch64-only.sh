#!/bin/bash

# Move to the Rust library directory
cd ../calculator-ffi/

# Build the Rust library
cargo build --profile release-smaller --target aarch64-apple-darwin

# Generate Kotlin bindings using uniffi-bindgen
cargo run --bin uniffi-bindgen generate --library ./target/aarch64-apple-darwin/release-smaller/libcalculatorffi.dylib --language kotlin --out-dir ../calculator-android/lib/src/main/kotlin/ --no-format

# Copy the binary to the Android resources directory
cp ./target/aarch64-apple-darwin/release-smaller/libcalculatorffi.dylib ../calculator-android/lib/src/main/resources/darwin-aarch64/libcalculatorffi.dylib
