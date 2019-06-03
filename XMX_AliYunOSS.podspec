#
# Be sure to run `pod lib lint XMX_AliYunOSS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XMX_AliYunOSS'
  s.version          = '0.1.0'
  s.summary          = 'A short description of XMX_AliYunOSS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/736497373/XMX_AliYunOSS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '736497373' => '736497373@qq.com' }
  s.source           = { :git => 'https://github.com/736497373/XMX_AliYunOSS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XMX_AliYunOSS/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XMX_AliYunOSS' => ['XMX_AliYunOSS/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  #s.frameworks = 'SystemConfiguration'
  s.dependency 'AliyunOSSiOS'
  s.dependency 'AFNetworking'
end
