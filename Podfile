# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SwiftNetwork' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'FloatingPanel'
  pod 'SDWebImage'
  pod 'TransitionButton'

  #pod 'SPPermissions/Contacts'
  #pod 'SPPermissions/Camera'
  #pod 'SPPermissions/PhotoLibrary'
  #pod 'SPPermissions/Location'
  #pod 'SPPermissions/Microphone'
  #pod 'SPPermissions/Notification'

  post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end


  # Pods for SwiftNetwork

  target 'SwiftNetworkTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwiftNetworkUITests' do
    # Pods for testing
  end

end
