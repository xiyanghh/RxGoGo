//
//  AppTools.swift
//  manager
//
//  Created by xiyanghh on 2018/3/28.
//

import UIKit
import Foundation
import CoreLocation

//MARK:Size
//屏宽
let kScreenWidth = UIScreen.main.bounds.size.width
//屏高
let kScreenHeight = UIScreen.main.bounds.size.height
//屏幕 size
let kScreenSize = UIScreen.main.bounds.size
//iPhoneX的上下高度
let xTop = 88
let xBottom = 34

//MARK:颜色
let colorMain = UIColor.init(hexString: "1E90FF")
let colorLine = UIColor.init(hexString: "E8E8E8")
let colorBG = UIColor.init(hexString: "F6F6F6")
let colorBorder = UIColor.init(hexString: "cccccc")
let color333 = UIColor.init(hexString: "333333")
let color666 = UIColor.init(hexString: "666666")
let color444 = UIColor.init(hexString: "444343")
let color999 = UIColor.init(hexString: "999999")
let colorEEE = UIColor.init(hexString: "EEEEEE")
let color675 = UIColor.init(hexString: "FF6754")

let colorEnabled = UIColor.init(hexString: "FFFFFF")

//MARK:字体
let titilFont = UIFont.systemFont(ofSize: 16)
let iconFont = UIFont.systemFont(ofSize: 13)

//MARK:系统
let kAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
let kOsVersion = UIDevice.current.systemVersion

//MARK:UserDefaults

let kUserDefault = UserDefaults.standard
let kSavePwd = "savePwd"
let kGysID = "currentGysID"
let kGysName = "organizationName"
let kUserInfo = "UserInfo"
let kuName = "userName"
let kuPwd = "userPwd"

let kPageSize = "10"

//MARK:正则
enum Validate {
    
    case email(_: String)
    case phoneNum(_: String)
    case carNum(_: String)
    case username(_: String)
    case password(_: String)
    case nickname(_: String)
    
    case URL(_: String)
    case IP(_: String)
    
    var isRight: Bool {
        var predicateStr: String!
        var currObject: String!
        
        switch self {
        case let .email(str):
            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            currObject = str
        case let .phoneNum(str):
            predicateStr = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
            currObject = str
        case let .carNum(str):
            predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
            currObject = str
        case let .username(str):
            predicateStr = "^[A-Za-z0-9]{6,20}+$"
            currObject = str
        case let .password(str):
            predicateStr = "^[a-zA-Z0-9]{8,20}+$"
            currObject = str
        case let .nickname(str):
            predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
            currObject = str
        case let .URL(str):
            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
            currObject = str
        case let .IP(str):
            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            currObject = str
        }
        
        let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
        return predicate.evaluate(with: currObject)
    }
}


class AppTools: NSObject {
    
    func formatTimeForTimeStamp(_ time: Int) -> String{
        
        let timeInterval = TimeInterval(time/1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dformatter.string(from: date)
    }
    
    func formatTimeForData(_ date: Date) -> String{
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        
        return dformatter.string(from: date)
    }
    
    func getTimeNow(_ type: String = "yyyy-MM-dd") -> String{
        
        let date = Date()
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = type
        
        return dformatter.string(from: date)
    }
    
    //根据经纬度获取地址
    func lonLatToCity(_ location: CLLocation, result: @escaping (_ address: String) -> ()){
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemark, error) in
            
            guard let p = placemark?.first else{
                return result("定位失败，位置信息错误")
            }
            
            var address = ""
            
            if let administrativeArea = p.administrativeArea {
                address.append(administrativeArea)
            }
            if let subAdministrativeArea = p.subAdministrativeArea {
                address.append(subAdministrativeArea)
            }
            if let locality = p.locality {
                address.append(locality)
            }
            if let subLocality = p.subLocality {
                address.append(subLocality)
            }
            if let thoroughfare = p.thoroughfare {
                address.append(thoroughfare)
            }
            if let subThoroughfare = p.subThoroughfare {
                address.append(subThoroughfare)
            }
//            if let name = p.name {
//                address.append(name)
//            }
            
            result(address)
        
        }
    }
    
    //检测定位模块开启
    func isLocationServiceOpen() -> Bool {
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied {
            return true
        } else {
            return false
        }
    }

}

extension UIImage {
    static func createImageWithColor(_ color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
}

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
}




