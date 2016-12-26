# AugmentedButton
UIButton subclass with augmented functionality


## Requirements

* iOS 8.0+
* Xcode 8

## Installation

#### Via [CocoaPods](http://cocoapods.org)
 
The easiest way to install **AugmentedButton** is via CocoaPods. 

1. Add this line to your Podfile:
```ruby
pod 'AugmentedButton'
```
2. Run `pod install`. 

#### Via [Carthage](https://github.com/Carthage/Carthage)

To install **AugmentedButton** using Carthage.

1. Add the following to your *Cartfile*:
```ruby
github "tapsandswipes/AugmentedButton"
```
2. Run `carthage update`
3. Add the framework as described in [Carthage Readme](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)


#### Via [Swift Package Manager](https://github.com/apple/swift-package-manager)

1. Add `.Package(url: "https://github.com/tapsandswipes/AugmentedButton.git", "1.0.0")` to your `Package.swift` inside `dependencies`:
```swift
import PackageDescription

let package = Package(
	name: "yourapp",
	dependencies: [
		.Package(url: "https://github.com/tapsandswipes/AugmentedButton.git", "1.0.0")
 	]
)
```
2. Run `swift build`.
 
 
#### Manual
 
You can also install it manually by copying to your project the contents of the directory `Sources`.


## Contact

- [Personal website](http://tapsandswipes.com)
- [GitHub](http://github.com/tapsandswipes)
- [Twitter](http://twitter.com/acvivo)
- [LinkedIn](http://www.linkedin.com/in/acvivo)
- [Email](mailto:antonio@tapsandswipes.com)

If you use/enjoy AugmentedButton, let me know!


## License

### MIT License

Copyright (c) 2016 Antonio Cabezuelo Vivo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
