# calculator-swift

This project builds a Swift package that provides [Swift] language bindings for the 
[`calculator`] library. The Swift language bindings are created by the [`calculator-ffi`] project which is included as a module of this repository. 

## How to Use

To use the Swift language bindings for [`calculator`] in your [Xcode] iOS or MacOS project, add the github repository (https://github.com/uniffi-bindings-template/Calculator) and select one of the release versions. You may then import and use the `Calculator` library in your Swift code. For example:

```swift
import Calculator

...

```

### How to test

```shell
swift test
```

[Swift]: https://developer.apple.com/swift/
[Xcode]: https://developer.apple.com/documentation/Xcode
