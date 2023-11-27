platform :ios, '13.0'

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
post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end

end

