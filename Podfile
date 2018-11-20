Pod

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

def common_pods_for_target

    #Swift
    pod 'Alamofire'
    pod 'Moya'   #配合Alamofire使用
    pod 'Moya/RxSwift'
    pod 'ObjectMapper'
    pod 'Moya-ObjectMapper'
    pod 'Result'
    pod 'SwiftyJSON'
    
    #工具
    pod 'IQKeyboardManagerSwift'
#    pod 'CryptoSwift'           #加密
#    pod 'ReachabilitySwift'     #网络检测

    #Rx
#    pod 'ReactiveCocoa'     #RAC
    pod 'RxSwift'           #RxSwift的必备库
    pod 'RxCocoa'           #UIKit Foundation 进行 Rx 化
    pod 'RxSwiftExt'
#    pod 'RxSwiftX'         #Rx UITableViewDelegate拓展  国人
    pod 'RxDataSources'    #Rx 使用tableView的数据源方法
#    pod 'ReactorKit'       #配合Rx使用的一种架构
#    https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/architecture/reactorkit.html

    #Ext
    pod 'SnapKit'           #视图约束库
    pod 'EZSwiftExtensions'
#    pod 'Kingfisher'       #图片加载库
#    pod 'Then'             #提供快速初始化的语法
#    pod 'Reusable'         #帮助我们优雅的使用自定义cell和view,不再出现Optional

    #UI
#    pod 'EmptyDataSet-Swift'   #空数据
#    pod 'PPBadgeViewSwift'     #角标
#    pod 'CVCalendar'           #日历

    #OC
#    pod 'SVProgressHUD'        #简单易用的HUD
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
