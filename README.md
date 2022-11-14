# Readme
Build the library for Android:
1. Fire the `buildAndroidLib` gradle task in the `calculator-android` directory
2. Publish it to your local Maven
```shell
cd calculator-android
./gradlew buildAndroidLib
./gradlew publishToMavenLocal
# The task above will publish your library at
# ~/.m2/repository/org/rustylibs/calculator-android/0.1.0/
```

You should then be able to use the library by adding it like any other dependency in an Android project, given you add mavenLocal() to your list of repositories to fetch dependencies from:
```kotlin
// build.gradle.kts
repositories {
    mavenCentral()
    mavenLocal()
}
```
