Pod::Spec.new do |s|
  
  s.name = "AugmentedButton"
  s.version = "1.3.1"
  s.summary = "UIButton subclasses with augmented functionality."
  s.homepage = "https://github.com/tapsandswipes/AugmentedButton"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.authors = { "Antonio Cabezuelo Vivo" => 'antonio@tapsandswipes.com' }
  s.social_media_url = "http://twitter.com/acvivo"

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = '10.15'
  s.swift_version = "5.0"
  s.source = { :git => "https://github.com/tapsandswipes/AugmentedButton.git", :tag => "#{s.version}" }
  s.source_files = "Sources/*.swift"
  
end