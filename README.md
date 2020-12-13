# JZStatusBar

[![CI Status](https://img.shields.io/travis/jiahao_zhu98@outlook.com/JZStatusBar.svg?style=flat)](https://travis-ci.org/jiahao_zhu98@outlook.com/JZStatusBar)
[![Version](https://img.shields.io/cocoapods/v/JZStatusBar.svg?style=flat)](https://cocoapods.org/pods/JZStatusBar)
[![License](https://img.shields.io/cocoapods/l/JZStatusBar.svg?style=flat)](https://cocoapods.org/pods/JZStatusBar)
[![Platform](https://img.shields.io/cocoapods/p/JZStatusBar.svg?style=flat)](https://cocoapods.org/pods/JZStatusBar)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Minimum iOS Target: 9.0

## Installation

JZStatusBar is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JZStatusBar'
```

## Usage

`JZStatusBar` can be laid out via both the frame based layout and auto layout. It is can also be used in .xib, you can just simply place a UIView and change its class to `JZStatusBar`.

```swift
/* It is not necessary to be initialized with a frame */
let statusBar = JZStatusBar(/*frame: <any CGRect>*/)
view.addSubview(statusBar)
```

## Author

朱嘉皓, jiahao_zhu98@outlook.com

## License

JZStatusBar is available under the MIT license. See the LICENSE file for more info.
