rustup install nightly-x86_64-apple-darwin
rustup component add rust-src --toolchain nightly-x86_64-apple-darwin
rustup target add aarch64-apple-ios x86_64-apple-ios
rustup target add aarch64-apple-ios-sim --toolchain nightly
rustup target add aarch64-apple-darwin x86_64-apple-darwin

pushd calculator-ffi
cargo run --package ffi-bindgen -- --language swift --out-dir ../calculator-swift/Sources/Calculator
popd

cargo build --package calculator-ffi --profile release-smaller --target x86_64-apple-darwin
cargo build --package calculator-ffi --profile release-smaller --target aarch64-apple-darwin
cargo build --package calculator-ffi --profile release-smaller --target x86_64-apple-ios
cargo build --package calculator-ffi --profile release-smaller --target aarch64-apple-ios
cargo +nightly build --package calculator-ffi --release -Z build-std --target aarch64-apple-ios-sim

mkdir -p target/lipo-ios-sim/release-smaller
lipo target/aarch64-apple-ios-sim/release/libcalculatorffi.a target/x86_64-apple-ios/release-smaller/libcalculatorffi.a -create -output target/lipo-ios-sim/release-smaller/libcalculatorffi.a
mkdir -p target/lipo-macos/release-smaller
lipo target/aarch64-apple-darwin/release-smaller/libcalculatorffi.a target/x86_64-apple-darwin/release-smaller/libcalculatorffi.a -create -output target/lipo-macos/release-smaller/libcalculatorffi.a

pushd calculator-swift
mv Sources/Calculator/calculator.swift Sources/Calculator/Calculator.swift
cp Sources/Calculator/calculatorFFI.h calculatorFFI.xcframework/ios-arm64/calculatorFFI.framework/Headers
cp Sources/Calculator/calculatorFFI.h calculatorFFI.xcframework/ios-arm64_x86_64-simulator/calculatorFFI.framework/Headers
cp Sources/Calculator/calculatorFFI.h calculatorFFI.xcframework/macos-arm64_x86_64/calculatorFFI.framework/Headers
cp ../target/aarch64-apple-ios/release-smaller/libcalculatorffi.a calculatorFFI.xcframework/ios-arm64/calculatorFFI.framework/calculatorFFI
cp ../target/lipo-ios-sim/release-smaller/libcalculatorffi.a calculatorFFI.xcframework/ios-arm64_x86_64-simulator/calculatorFFI.framework/calculatorFFI
cp ../target/lipo-macos/release-smaller/libcalculatorffi.a calculatorFFI.xcframework/macos-arm64_x86_64/calculatorFFI.framework/calculatorFFI
rm Sources/Calculator/calculatorFFI.h
rm Sources/Calculator/calculatorFFI.modulemap
#rm calculatorFFI.xcframework.zip || true
#zip -9 -r calculatorFFI.xcframework.zip calculatorFFI.xcframework