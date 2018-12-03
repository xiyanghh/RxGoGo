//
//  AppViewController.swift
//  tvJapan
//
//  Created by com on 2018/11/23.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AppViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("2")
    }
    
    @objc dynamic func test(_ value:String) {
        print("2：\(value)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.rx.sentMessage(#selector(AppViewController.test(_:)))
            .subscribe( onNext: { value  in
                print("1: \(value[0])")
            }).disposed(by: disposeBag)
        
        
        self.rx.methodInvoked(#selector(AppViewController.test(_:)))
            .map({ a in
                return try self.castOrThrow(String.self, a[0])
            })
            .subscribe(onNext: { value in
                print("3：\(value)")
            })
            .disposed(by: disposeBag)
        
        
        self.test("Rxx")
        
        
//        self.rx.sentMessage(#selector(AppViewController.viewWillAppear(_:)))
//            .subscribe(onNext: { (value) in
//                print("1")
//            }).disposed(by: disposeBag)
//
//        self.rx.methodInvoked(#selector(AppViewController.viewWillAppear(_:)))
//            .subscribe(onNext: { (value) in
//                print("3")
//            }).disposed(by: disposeBag)
        
        
        
        //对状态变化进行订阅
//        UIApplication.shared.rx
//            .didBecomeActive
//            .subscribe { (appState) in
//                print("进入活动状态")
//        }.disposed(by: disposeBag)
//
//        UIApplication.shared.rx
//            .willResignActive
//            .subscribe(onNext: { _ in
//                print("进入非活动状态")
//            }).disposed(by: disposeBag)
//
//
//        //对状态变化序列进行订阅
//        UIApplication.shared.rx
//            .state
//            .subscribe(onNext: { (state) in
//                switch state{
//                case .active:
//                    print("进入活动状态")
//                case .inactive:
//                    print("进入非活动状态")
//                case .background:
//                    print("进入后台状态")
//                case .terminated:
//                    print("应用终止")
//                }
//            }).disposed(by: disposeBag)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func castOrThrow<T>(_ resultType: T.Type, _ objecet: Any) throws -> T {
        guard let returnValue = objecet as? T else {
            throw RxCocoaError.castingError(object: objecet, targetType: resultType)
        }
        return returnValue
    }


}


