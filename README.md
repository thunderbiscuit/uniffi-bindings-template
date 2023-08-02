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

<br>

## Build the library for iOS
1. Run the `build-local-swift.sh` script
```shell
source build-local-swift.sh
```
See the [Swift readme](./calculator-swift/README.md) for more details.

<br>

## A few important pieces of this template
### The custom Gradle plugin for the Android library
This plugin lives in the `calculator-android/plugins/` directory, and collects the tasks of building the native binaries, building the glue code file, and putting them all in the correct places in the library to prepare for packaging. The plugin exposes the `buildAndroidLib` task to the Gradle build tool.

### Reducing the size of the final binaries
A special cargo profile is added with many flags turned on/off which allows to significantly reduce binary size.
