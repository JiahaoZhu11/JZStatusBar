#
# Be sure to run `pod lib lint JZStatusBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JZStatusBar'
  s.version          = '0.1.0'
  s.summary          = 'A simple customized status bar.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
JZStatusBar is a simple customized status bar displaying the network status, time and battery status.
                       DESC

  s.homepage         = 'https://github.com/JiahaoZhu11/JZStatusBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '朱嘉皓' => 'jiahao_zhu98@outlook.com' }
  s.source           = { :git => 'https://github.com/JiahaoZhu11/JZStatusBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version    = '4.0'

  s.ios.deployment_target = '9.0'

  s.source_files = 'JZStatusBar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JZStatusBar' => ['JZStatusBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 4.0'
   s.dependency 'JZBattery'
end
