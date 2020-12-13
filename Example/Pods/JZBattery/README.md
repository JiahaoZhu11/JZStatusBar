# JZBattery

[![CI Status](https://img.shields.io/travis/朱嘉皓/JZBattery.svg?style=flat)](https://travis-ci.org/朱嘉皓/JZBattery)
[![Version](https://img.shields.io/cocoapods/v/JZBattery.svg?style=flat)](https://cocoapods.org/pods/JZBattery)
[![License](https://img.shields.io/cocoapods/l/JZBattery.svg?style=flat)](https://cocoapods.org/pods/JZBattery)
[![Platform](https://img.shields.io/cocoapods/p/JZBattery.svg?style=flat)](https://cocoapods.org/pods/JZBattery)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Minimum iOS Target: 9.0

## Installation

JZBattery is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JZBattery'
```

## Usage

`JZBatteryView` can be laid out via both the frame based layout and auto layout. It is can also be used in .xib, you can just simply place a UIView and change its class to `JZBatteryView`.

```swift
/* It is not necessary to be initialized with a frame */
let battery = JZBatteryView(/*frame: <any CGRect>*/)
view.addSubview(battery)
```

## Property

The properties are listed below:

| Property                   | Access Right | Description                                                  |
| :------------------------- | ------------ | ------------------------------------------------------------ |
| currentBatteryState        | Read-only    | It returns the current battery state.                        |
| currentBatteryLevel        | Read-only    | It returns the current battery level, scaled from 0 to 1.    |
| widthToHeightRatio         | Readwrite    | It represents the width : height ratio of the battery, the default value is 2.5. |
| style                      | Readwrite    | It represents the color style of the battery, the default value is .dark. |
| batteryStateChangeCallback | Readwrite    | It will be called after receiving a notification for the change in battery state. |
| batteryLevelChangeCallback | Readwrite    | It will be called after receiving a notification for the change in battery level. |

## Author

朱嘉皓, jiahao.zhu98@outlook.com

## License

JZBattery is available under the MIT license. See the LICENSE file for more info.
