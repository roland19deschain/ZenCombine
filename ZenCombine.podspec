Pod::Spec.new do |s|
  s.name             = 'ZenCombine'
  s.version          = '0.1.0'
  s.swift_version    = '5.0'
  s.summary          = 'ZenCombine is a collection of extensions and functions for Combine framework.'
  s.description      = <<-DESC
  ZenCombine is a collection of convenient and concise extensions and functions for Combine framework.
                       DESC
  s.homepage         = 'https://github.com/roland19deschain/ZenCombine'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexey Roik' => 'roland19deschain@gmail.com' }
  s.source           = { :git => 'https://github.com/roland19deschain/ZenCombine.git', :tag => s.version }
  s.requires_arc     = true
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  s.source_files     = 'Sources/ZenCombine/**/*{swift}'
end
