use_frameworks!
inhibit_all_warnings!
platform :ios, '12.0'

def networkPods
  pod 'Alamofire', '~> 5.4'
  pod 'AlamofireImage', '~> 4.2'
end

def commonPods
  pod 'RxSwift', '~> 5.1'
  pod 'RxCocoa', '~> 5.1'
end

target 'Github App' do
  commonPods
  networkPods
end

target 'Github AppTests' do
  commonPods
  networkPods
  pod 'RxTest', '~> 5.1'
end

deployment_target = '12.0'

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end
