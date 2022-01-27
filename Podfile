use_frameworks!
inhibit_all_warnings!
platform :ios, '13.0'

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
