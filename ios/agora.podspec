#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'agora'
  s.version          = '0.0.1'
  s.summary          = 'agora plugin.'
  s.description      = <<-DESC
agora plugin.
                       DESC
  s.homepage         = 'http://ninefrost.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ninefrost' => 'ailei@ninefrost.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.static_framework = true
  s.dependency 'Flutter'
# s.dependency 'AgoraRtcEngine_iOS'
  s.frameworks = ["Accelerate", "SystemConfiguration", "CoreMedia", "AudioToolbox", "CoreTelephony", "AVFoundation"]
  s.libraries = ["c++", "resolv"]
  s.preserve_paths = "Libs/*.a"
  s.preserve_paths = "Libs/*.framework"
  s.vendored_libraries = "**/*.a"
  s.vendored_frameworks="**/*.framework"
  s.ios.deployment_target = "9.3"
end

