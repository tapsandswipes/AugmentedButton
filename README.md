[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)]() [![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat)](https://developer.apple.com/swift) [![CocoaPods](https://img.shields.io/cocoapods/v/AugmentedButton.svg)]() [![CocoaPods](https://img.shields.io/cocoapods/p/AugmentedButton.svg)]() [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# AugmentedButton 
UIButton subclass with augmented functionality

## Provided API

#### New setters for states

- **backgroundColor**
- **tintColor**
- **borderColor**
- **borderWidth**
- **cornerRadius**

Each property has its own APIs in the form: 

```swift
func setXxx(_ value: Value, for state: UIControl.State)
func xxx(for state: UIControlState) -> Value
func currentXxx() -> Value
```

with `Value` equals to the type of each property in `UIButton`. For example, for `backgroundColor` the API is:

```swift
func setBackgroundColor(_ color: UIColor?, for state: UIControl.State)
func backgroundColor(for state: UIControl.State) -> UIColor?
func currentBackgroundColor() -> UIColor?
```

#### Set any button property for any button state

New API to set any property supported by UIButton for any state

```swift
func setValue<Value>(_: Value, forKeyPath: ReferenceWritableKeyPath<AugmentedButton, Value>, for: UIControl.State)
func valueForKeyPath<Value>(_: KeyPath<AugmentedButton, Value>, for: UIControl.State) -> Value?
func currentValueForKeyPath<Value>(_: KeyPath<AugmentedButton, Value>) -> Value
````

#### Apply a group of actions for any button state

```swift
func setActions(_ block: @escaping (AugmentedButton) -> Void, named name: String? = default, for state: UIControl.State)
```

Always set actions for `.normal` state if you want them to be reset


#### Add target/actions for long press and state changes on button

Support for two new `UIControl.Event` values added:

* `.stateChanged` for any change in the button state property 
* `.longPress` for long press gestures on button

Use the standard API for target/actions:

```swift
augmentedButton.addTarget(self, action: #selector(onLongPress), for: .longPress)
augmentedButton.addTarget(self, action: #selector(buttonStateChanged(_:)), for: .stateChanged)

```

You can see all public API [here](https://tapsandswipes.github.io/AugmentedButton/documentation/augmentedbutton/)

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

1. Add `.Package(url: "https://github.com/tapsandswipes/AugmentedButton.git", "1.3")` to your `Package.swift` inside `dependencies`:
```swift
import PackageDescription

let package = Package(
	name: "yourapp",
	dependencies: [
		.Package(url: "https://github.com/tapsandswipes/AugmentedButton.git", "1.3")
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
