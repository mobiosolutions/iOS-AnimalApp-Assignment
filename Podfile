# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'Animal' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Animal

pod 'Alamofire'
pod 'SVProgressHUD'
pod 'SDWebImage'
pod 'MBProgressHUD', '~> 1.2.0'


  target 'AnimalTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
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
