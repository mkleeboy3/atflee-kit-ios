#
# Be sure to run `pod lib lint AtfleeKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AtfleeKit'
  s.version          = '0.0.2'
  s.summary          = 'Atflee bluetooth interface for iOS'

  s.description      = <<-DESC
  Atflee bluetooth interface for iOS  
                       DESC

  s.homepage         = 'https://github.com/mkleeboy3/atflee-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mkleeboy3@huray.net' => '...' }
  s.source           = { :git => 'https://github.com/mkleeboy3/atflee-kit-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'

  s.vendored_frameworks = 'AtfleeKit.xcframework'
  s.preserve_paths = 'AtfleeBaseKit.framework/**/*'
end
