#
# Be sure to run `pod lib lint TestPublicccc.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TestPublicccc'
  s.version          = '1.1.4'
  s.summary          = 'A short description of TestPublicccc.'
#  s.resource = 'TestPublicccc/TestPublicccc.bundle'
#  s.resource         = 'Assets.xcassets'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Test_Public'

  s.homepage         = 'https://github.com/zhangguang1024/TestPublicccc'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhangguang' => 'zhangguang@drojian.dev' }
  s.source           = { :git => 'https://github.com/zhangguang1024/TestPublicccc.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'TestPublicccc/Classes/**/*'
#
#  s.resource_bundles = {
#    'TestPublicccc' => ['TestPublicccc/Assets/*']
#  }
  s.resource_bundles = {
       'TestPublicccc' => ['TestPublicccc/Assets/*']
     }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
