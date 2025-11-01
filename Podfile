platform :ios, '14.0'

target 'tourmeapp (iOS)' do
  # Comment the next line if you don't want to use dynamic frameworks
  # Pods for tourmeapp (iOS)
  use_frameworks!

  pod 'Amplify', "1.19.0"
  pod 'AmplifyPlugins/AWSCognitoAuthPlugin', "1.19.0"
  pod 'AmplifyPlugins/AWSDataStorePlugin', "1.19.0"
  pod 'AmplifyPlugins/AWSAPIPlugin', "1.19.0"
  
  pod 'Purchases'
  pod 'AWSS3', '2.27.1'
  pod 'FlagKit'
  pod 'lottie-ios', "3.4.3"
  pod 'PayPal/PayPalNativePayments'
  pod 'AVPlayerViewController-Subtitles'

  post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        xcconfig_path = config.base_configuration_reference.real_path
        xcconfig = File.read(xcconfig_path)
        xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
        File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
    end
  end
end

  

end

