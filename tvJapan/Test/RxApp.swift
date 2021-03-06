//
//  RxApp.swift
//  tvJapan
//
//  Created by com on 2018/11/23.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public enum AppState{
    case active
    case inactive
    case background
    case terminated
}

//扩展
extension UIApplicationState {
    //将其转为我们自定义的应用状态枚举
    func toAppState() -> AppState{
        switch self {
        case .active:
            return .active
        case .inactive:
            return .inactive
        case .background:
            return .background
        }
    }
}

//UIApplication的Rx扩展
extension Reactive where Base: UIApplication{
    
    //代理委托
    var delegate: DelegateProxy<UIApplication, UIApplicationDelegate>{
        return AppExt.proxy(for: base)
    }
    
    var didBecomeActive: Observable<AppState>{
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationDidBecomeActive(_:)))
            .map{ _ in return .active }
    }
    
    //应用从活动状态进入非活动状态
    var willResignActive: Observable<AppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationWillResignActive(_:)))
            .map{ _ in return .inactive}
    }
    
    //应用从后台恢复至前台（还不是活动状态）
    var willEnterForeground: Observable<AppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationWillEnterForeground(_:)))
            .map{ _ in return .inactive}
    }
    
    //应用进入到后台
    var didEnterBackground: Observable<AppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationDidEnterBackground(_:)))
            .map{ _ in return .background}
    }
    
    //应用终止
    var willTerminate: Observable<AppState> {
        return delegate
            .methodInvoked(#selector(UIApplicationDelegate.applicationWillTerminate(_:)))
            .map{ _ in return .terminated}
    }
    
    var state: Observable<AppState> {
        return Observable.of(
            didBecomeActive,
            willResignActive,
            willEnterForeground,
            didEnterBackground,
            willTerminate)
            .merge()
            .startWith(base.applicationState.toAppState())
    }
    
}
