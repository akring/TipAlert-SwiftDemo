Pod::Spec.new do |s|

  s.name         = "TipAlert"
  s.version      = "1.0.0"
  s.summary      = "Beautiful alert with picture and button. "

  s.description  = <<-DESC
                   TipAlert is a lightweight and pure Swift implemented library for showing alert with picture and button. Always used for uset tips and rateing.
                   DESC

  s.homepage     = "https://github.com/akring/TipAlert-SwiftDemo"
  s.screenshots  = "https://camo.githubusercontent.com/07700e4ab0b2691f658e9e35c6c65059db69fff5/687474703a2f2f3774653773792e636f6d312e7a302e676c622e636c6f7564646e2e636f6d2f546970416c6572742e706e67"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "akring" => "ddflj3210@gmail.com" }
  s.social_media_url   = "http://twitter.com/ddflj3310"

  s.ios.deployment_target = "9.0"

  s.source       = { :git => "git@github.com:akring/TipAlert-SwiftDemo.git", :tag => s.version }
  
  s.source_files  = ["TipAlert/*.swift", "TipAlert/TipAlert.h", "TipAlert/TipAlert.swift"]
  s.public_header_files = ["TipAlert/TipAlert.h"]
  
  s.requires_arc = true
  s.framework = ""

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end