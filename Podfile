# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CrowdCircle' do
	use_frameworks!

	 pod 'RealmSwift', :git => 'https://github.com/realm/realm-cocoa.git', :submodules => true   
     pod 'Eureka',  :git => 'https://github.com/xmartlabs/Eureka.git', :branch => 'feature/Xcode9-Swift3_2'

    pod 'SwiftSpinner', :git => 'https://github.com/TimOliver/SwiftSpinner.git'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
