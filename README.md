# Readme
## Build the library for Android
1. Fire the `buildAndroidLib` gradle task in the `calculator-android` directory
2. Publish it to your local Maven (the library will appear at `~/.m2/repository/org/rustylibs/calculator-android/0.1.0/`)
```shell
cd calculator-android
./gradlew buildAndroidLib
./gradlew publishToMavenLocal
```

You should then be able to use the library by adding it like any other dependency in an Android project, given you add mavenLocal() to your list of repositories to fetch dependencies from:
```kotlin
// build.gradle.kts
repositories {
    mavenCentral()
    mavenLocal()
}
```

## A few important pieces of this template
### The custom Gradle plugin for the Android library
This plugin lives in the `calculator-android/plugins/` directory, and collects the tasks of building the native binaries, building the glue code file, and putting them all in the correct places in the library to prepare for packaging. The plugin exposes the `buildAndroidLib` task to the Gradle build tool.

### The ffi-bindgen cli tool
The task of building language bindings using uniff-rs can be thought of as consisting of two steps: (1) building the native binaries for each target architecture, (2) building a "glue code" file in the target language, which will call the native binaries. 

The `calculator-ffi/ffi-bingen/` directory contains a binary package which allows us to build the glue code files for each of the bindings (`calculator.kt` and `calculator.swift`) using a well-defined `uniffi-bindgen` version. In general, this cli tool can simply be downloaded from crates.io, but a requirement of the uniffi-rs library is that the native binaries produced by the `uniffi-rs` crate use the same version for that crate as the one used in the cli bindgen tool which produces the glue code. That these two versions be the same is not enforced at build time because the processes are separate, and it is therefore common for unaware contributors/developers to have problems with libraries where the binaries where produced by a different version than the glue code was. The ffi-bindgen cli tool ensures that all contributors need not downloading the uniffi-bindgen tool and instead build the glue code using the same provided tool (ffi-bindgen).

### Reducing the size of the final binaries
A special cargo profile is added with many flags turned on/off which allows to significantly reduce binary size.
