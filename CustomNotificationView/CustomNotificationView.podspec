Pod::Spec.new do |spec|
  spec.name         = "CustomNotificationView"
  spec.version      = "1.0.0"
  spec.summary      = "A simple framework for a custom Notification view."

  spec.homepage     = "https://github.com/eslamali423/CustomNotificationView"
  spec.license      = "MIT"
  spec.author       = { "Eslam Ali" => "eslam.ali4233@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/eslamali423/CustomNotificationView.git", :tag => spec.version.to_s }

  spec.source_files  = "CustomNotificationView/**/*.{swift}"
  
  spec.resource_bundles = {
  'CustomNotificationView' => ['CustomNotificationView/**/*.{xib}', 'CustomNotificationView/**/Resources/LottieFiles/*.{json}', 'CustomNotificationView/**/Resources/Sounds/*.{mp3}']
}

spec.resources = 'CustomNotificationView/**/*.{xib}', 'CustomNotificationView/**/Resources/LottieFiles/*.{json}', 'CustomNotificationView/**/Resources/Sounds/*.{mp3}'
  spec.frameworks = 'UIKit'
  spec.dependency 'lottie-ios'

  spec.swift_versions = "5.0"
end
