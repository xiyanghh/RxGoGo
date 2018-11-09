Pod

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def common_pods_for_target

    #Swift
    pod 'Alamofire'
    pod 'SnapKit'
#    pod 'Kingfisher'  #图片加载库
    pod 'SnapKit'     #视图约束库
    pod 'SwiftyJSON'
    pod 'EZSwiftExtensions'
    pod 'IQKeyboardManagerSwift'
#    pod 'CryptoSwift'  #加密
    
#    pod 'ReachabilitySwift'  #网络检测
#    pod 'ReactiveCocoa'  #RAC
    pod 'RxSwift'        #RxSwift的必备库
    pod 'RxCocoa'        #对 UIKit Foundation 进行 Rx 化
#    pod 'RxDataSources'  #优雅的使用tableView的数据源方法

    #UI
#    pod 'EmptyDataSet-Swift'  #空数据
#    pod 'Then'     #提供快速初始化的语法
#    pod 'Reusable' #帮助我们优雅的使用自定义cell和view,不再出现Optional
#    pod 'PPBadgeViewSwift'  #角标
#    pod 'CVCalendar'  #日历

    #OC
#    pod 'SVProgressHUD' #简单易用的HUD
#    pod 'MJRefresh' 
    
   
end


#给目标添加库
target 'tvJapan' do
    common_pods_for_target
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'YES'
            config.build_settings['SWIFT_VERSION'] = ‘4.1’
        end
    end
end
