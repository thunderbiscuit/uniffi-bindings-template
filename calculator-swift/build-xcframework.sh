HEADERPATH="Sources/Calculator/CalculatorFFI.h"
MODMAPPATH="Sources/Calculator/CalculatorFFI.modulemap"
TARGETDIR="../calculator-ffi/target"
OUTDIR="."
RELDIR="release-smaller"
NAME="calculatorffi"
STATIC_LIB_NAME="lib${NAME}.a"
NEW_HEADER_DIR="../calculator-ffi/target/include"

# Set required rust version and install component and targets
rustup default 1.77.1
rustup component add rust-src
rustup target add aarch64-apple-ios      # iOS arm64
rustup target add x86_64-apple-ios       # iOS x86_64
rustup target add aarch64-apple-ios-sim  # simulator mac M1
rustup target add aarch64-apple-darwin   # mac M1
rustup target add x86_64-apple-darwin    # mac x86_64

cd ../calculator-ffi/ || exit

# Build calculator-ffi Rust library for supported apple targets
cargo build --package calculator-ffi --profile release-smaller --target x86_64-apple-darwin
cargo build --package calculator-ffi --profile release-smaller --target aarch64-apple-darwin
cargo build --package calculator-ffi --profile release-smaller --target x86_64-apple-ios
cargo build --package calculator-ffi --profile release-smaller --target aarch64-apple-ios
cargo build --package calculator-ffi --profile release-smaller --target aarch64-apple-ios-sim

# Build bdk-ffi Swift bindings and put in bdk-swift Sources
cargo run --bin uniffi-bindgen generate --library ./target/aarch64-apple-ios/release-smaller/libcalculatorffi.dylib --language swift --out-dir ../calculator-swift/Sources/Calculator --no-format

# Combine calculator-ffi static libs for aarch64 and x86_64 targets via lipo tool
mkdir -p target/lipo-ios-sim/release-smaller
mkdir -p target/lipo-macos/release-smaller
lipo target/aarch64-apple-ios-sim/release-smaller/libcalculatorffi.a target/x86_64-apple-ios/release-smaller/libcalculatorffi.a -create -output target/lipo-ios-sim/release-smaller/libcalculatorffi.a
lipo target/aarch64-apple-darwin/release-smaller/libcalculatorffi.a target/x86_64-apple-darwin/release-smaller/libcalculatorffi.a -create -output target/lipo-macos/release-smaller/libcalculatorffi.a

cd ../calculator-swift/ || exit

# Move calculator-ffi static lib header files to temporary directory
mkdir -p "${NEW_HEADER_DIR}"
mv "${HEADERPATH}" "${NEW_HEADER_DIR}"
mv "${MODMAPPATH}" "${NEW_HEADER_DIR}/module.modulemap"

# Remove old xcframework directory
rm -rf "${OUTDIR}/${NAME}.xcframework"

# Create new xcframework directory from calculator-ffi static libs and headers
xcodebuild -create-xcframework \
    -library "${TARGETDIR}/lipo-macos/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/aarch64-apple-ios/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -library "${TARGETDIR}/lipo-ios-sim/${RELDIR}/${STATIC_LIB_NAME}" \
    -headers "${NEW_HEADER_DIR}" \
    -output "${OUTDIR}/${NAME}.xcframework" 
