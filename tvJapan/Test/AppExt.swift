//
//  AppExt.swift
//  tvJapan
//
//  Created by com on 2018/11/23.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift



public class AppExt: DelegateProxy<UIApplication, UIApplicationDelegate>, UIApplicationDelegate, DelegateProxyType {
        

    public weak private(set) var application: UIApplication?
    
    init(appliaction: ParentObject) {
        self.application = appliaction
        super.init(parentObject: appliaction, delegateProxy: AppExt.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { (Parent) -> AppExt in
            AppExt(appliaction: Parent)
        }
    }

    
    public static func currentDelegate(for object: UIApplication) -> UIApplicationDelegate? {
        return object.delegate
    }
    
    public static func setCurrentDelegate(_ delegate: UIApplicationDelegate?, to object: UIApplication) {
        object.delegate = delegate
    }

    override open func setForwardToDelegate(_ forwardToDelegate: UIApplicationDelegate?,
                                            retainDelegate: Bool) {
        super.setForwardToDelegate(forwardToDelegate, retainDelegate: true)
    }
    

}


