Pod::Spec.new do |s|
  s.name             = 'DBAppleIDSign'
  s.version          = '1.0.0'
  s.summary          = 'AppleID Sign Kit.'
  s.description      = 'AppleID Sign Kit.'
  s.homepage         = 'https://github.com/DanboDuan/DBAppleIDSign'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bob' => 'bob170731@gmail.com' }
  s.source           = { :git => 'git@github.com:DanboDuan/DBAppleIDSign.git', :tag => s.version.to_s}
  s.ios.deployment_target = '8.0'
  s.default_subspec = 'Core'
  s.requires_arc = true
  s.static_framework = true
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES'}
  
  s.subspec 'Core' do |bd|
    bd.source_files = 'AppleIDSign/Core/**/*.{h,m,c}'
    bd.frameworks = 'Foundation','UIKit','WebKit','AuthenticationServices'
    bd.public_header_files = 'AppleIDSign/Core/public/*.h'
  end

  s.test_spec 'Tests' do |d|
    d.dependency 'DBAppleIDSign/Core'
    d.dependency 'XcodeCoverage','>= 1.3.2'
    d.source_files = 'AppleIDSign/Tests/**/*.{h,m,c}'
    
  end
  
end
