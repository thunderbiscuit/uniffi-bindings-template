pushd ../calculator-ffi/

rustup install nightly-x86_64-apple-darwin
rustup component add rust-src --toolchain nightly-x86_64-apple-darwin
rustup target add aarch64-apple-ios x86_64-apple-ios
rustup target add aarch64-apple-ios-sim --toolchain nightly
rustup target add aarch64-apple-darwin x86_64-apple-darwin

cargo run --features uniffi/cli --bin uniffi-bindgen generate src/calculator.udl --language swift --out-dir ../calculator-swift/Sources/Calculator --no-format

cargo build --package calculator-ffi --features uniffi/cli --profile release-smaller --target x86_64-apple-darwin
cargo build --package calculator-ffi --features uniffi/cli --profile release-smaller --target aarch64-apple-darwin
cargo build --package calculator-ffi --features uniffi/cli --profile release-smaller --target x86_64-apple-ios
cargo build --package calculator-ffi --features uniffi/cli --profile release-smaller --target aarch64-apple-ios
cargo +nightly build --package calculator-ffi --features uniffi/cli --release -Z build-std --target aarch64-apple-ios-sim

mkdir -p target/lipo-ios-sim/release-smaller
lipo target/aarch64-apple-ios-sim/release/libcalculatorffi.a target/x86_64-apple-ios/release-smaller/libcalculatorffi.a -create -output target/lipo-ios-sim/release-smaller/libcalculatorffi.a
mkdir -p target/lipo-macos/release-smaller
lipo target/aarch64-apple-darwin/release-smaller/libcalculatorffi.a target/x86_64-apple-darwin/release-smaller/libcalculatorffi.a -create -output target/lipo-macos/release-smaller/libcalculatorffi.a

popd

mv Sources/Calculator/calculator.swift Sources/Calculator/Calculator.swift
cp Sources/Calculator/calculatorFFI.h calculatorFFI.xcframework/ios-arm64/calculatorFFI.framework/Headers
cp Sources/Calculator/calculatorFFI.h calculatorFFI.xcframework/ios-arm64_x86_64-simulator/calculatorFFI.framework/Headers
cp Sources/Calculator/calculatorFFI.h calculatorFFI.xcframework/macos-arm64_x86_64/calculatorFFI.framework/Headers
cp ../calculator-ffi/target/aarch64-apple-ios/release-smaller/libcalculatorffi.a calculatorFFI.xcframework/ios-arm64/calculatorFFI.framework/calculatorFFI
cp ../calculator-ffi/target/lipo-ios-sim/release-smaller/libcalculatorffi.a calculatorFFI.xcframework/ios-arm64_x86_64-simulator/calculatorFFI.framework/calculatorFFI
cp ../calculator-ffi/target/lipo-macos/release-smaller/libcalculatorffi.a calculatorFFI.xcframework/macos-arm64_x86_64/calculatorFFI.framework/calculatorFFI
rm Sources/Calculator/calculatorFFI.h
rm Sources/Calculator/calculatorFFI.modulemap
