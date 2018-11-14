//
//  CreatViewController.swift
//  tvJapan
//
//  Created by com on 2018/11/12.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias JSON = Any

class CreatViewController: BaseViewController {
    
    let disposeBag =  DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //创建序列
//        let numbers: Observable<Int> = Observable.create { (observer) -> Disposable in
//
//            observer.onNext(0)
//            observer.onNext(1)
//            observer.onNext(2)
//            observer.onNext(3)
//            observer.onNext(4)
//            observer.onCompleted()
//
//            return Disposables.create()
//        }
        
        
//        let json: Observable<JSON> = Observable.create { (observer) -> Disposable in
//
//            observer.onNext("data")
//            observer.onCompleted()
////            observer.onError()
//
//            return Disposables.create()
//
//        }
//
//        json.subscribe(onNext: { (json) in
//
//        }, onError: { (error) in
//
//        }, onCompleted: {
//
//        }).disposed(by: disposeBag)
//
        
//        let textField = UITextField()
//        self.view.addSubview(textField)
//
//        // 作为可被监听的序列
//        let observable = textField.rx.text
//        observable.subscribe(onNext: { (string) in
//
//        }).disposed(by: disposeBag)
        
        
        //作为观察者
        //        let observer = textField.rx.text
        //        let text: Observable<String?> = ...
        //            text.bind(to: observer)
        
        //AsyncSubject  只发送最后一个元素 没有则不发
//        let subject = AsyncSubject<String>()
//
//        subject.subscribe{ print("3344",$0) }
//            .disposed(by: disposeBag)
//
//        subject.onNext("🐶")
//        subject.onNext("🐱")
//        subject.onNext("🐹")
//        subject.onCompleted()
        
        
        //PublishSubject 只发送订阅后的元素
//        let subject2 = PublishSubject<String>()
//
//        subject2.subscribe{ print("A", $0) }
//            .disposed(by: disposeBag)
//
//        subject2.onNext("🐶")
//        subject2.onNext("🐱")
//
//        subject2.subscribe{ print("B", $0) }
//            .disposed(by: disposeBag)
//
//        subject2.onNext("🅰️")
//        subject2.onNext("🅱️")
//
        
        
//        ReplaySubject 发送全部元素 不论何时
        //这里存在多个版本的 ReplaySubject，有的只会将最新的 n 个元素发送给观察者，有的只会将限制时间段内最新的元素发送给观察者。
        
//        let subject3 = ReplaySubject<String>.create(bufferSize: 1)
//
//        subject3
//            .subscribe{ ( print("A", $0)) }
//            .disposed(by: disposeBag)
//
//        subject3.onNext("🐶")
//        subject3.onNext("🐱")
//
//        subject3
//            .subscribe { print("B", $0) }
//            .disposed(by: disposeBag)
//
//        subject3.onNext("🅰️")
//        subject3.onNext("🅱️")
//
//
//    }
    
    
        //BehaviorSubject
        //最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。然后将随后产生的元素发送出来。
        
        
    }
    
    
    
} // end class
