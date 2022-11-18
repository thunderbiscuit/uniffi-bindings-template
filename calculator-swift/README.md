# calculator-swift

This project builds a Swift package that provides [Swift] language bindings for the 
[`calculator`] library. The Swift language bindings are created by the [`calculator-ffi`] project which is included as a module of this repository. 

## How to Use

To use the Swift language bindings for [`calculator`] in your [Xcode] iOS or MacOS project add 
the github repository (https://github.com/uniffi-bindings-template/Calculator) and select one of the 
release versions. You may then import and use the `Calculator` library in your Swift 
code. For example:

```swift
import Calculator

...

```

### How to test

```shell
swift test
```

### Example Projects

* TBD

## How to Build and Publish

If you are a maintainer of this project or want to build and publish this project to your 
own Github repository use the following steps:

1. If it doesn't already exist, create a new `release/0.MINOR` branch from the `master` branch.
2. Add a tag `v0.MINOR.0`.
3. Run the `publish-spm` workflow on Github from the `calculator-swift` repo for  version `0.MINOR.0`.

[Swift]: https://developer.apple.com/swift/
[Xcode]: https://developer.apple.com/documentation/Xcode
