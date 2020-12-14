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

If you want to use `JZStatusBar` in .xib, uncomment line 13 to enable the `@IBDesignable` attribute, but you might need to add the following code to your podfile to work around the "Image Not Found" error:

```ruby
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = [
      '$(FRAMEWORK_SEARCH_PATHS)'
    ]
  end
end
```

You can also check out issue [#5334](https://github.com/CocoaPods/CocoaPods/issues/5334) for any updates on this problem.

## Author

朱嘉皓, jiahao_zhu98@outlook.com

## License

JZStatusBar is available under the MIT license. See the LICENSE file for more info.
