platform :ios, '14.0'
use_frameworks!

target 'KinkyDungeonApp' do
  pod 'GCDWebServer', '~> 3.5.4'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
