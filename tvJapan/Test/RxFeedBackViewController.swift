//
//  RxFeedBackViewController.swift
//  tvJapan
//
//  Created by com on 2018/11/12.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

typealias State = Int

enum Event {
    case increment  // 增加
    case decrement  // 减少
}

//public static func system<State, Event>(
//    initialState: State,
//    reduce: @escaping (State, Event) -> State,
//    feedback: (Observable<State>) -> Observable<Event>...
//    ) -> Observable<State>


class RxFeedBackViewController: BaseViewController {
    
    var username = Variable("aa")
    var inName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()


        
        
//        _ = self.inName.rx.textInput <-> BehaviorRelay(value: username)
        
        
        // Do any additional setup after loading the view.
        
//        let obersver = Observable<Any>.create { (observer) -> Disposable in
//            observer.onNext("next")
//            observer.onCompleted()
////            observer.onError(nil)
//            return Disposables.create()
//        }
//
//        obersver.asDriver(onErrorJustReturn: "error")
//            .drive(onNext: { (next) in
//                print("next = \(next)")
//            }, onCompleted: {
//                print("completed")
//            }) {
//                print("onDisposed")
//        }.disposed(by: DisposeBag())
        
        //一个无限序列（每隔0.1秒创建一个序列数 ）
        let infiniteInterval$ = Observable<Int>
            .interval(0.1, scheduler: MainScheduler.instance)
            .do(
                onNext: { print("infinite$: \($0)") },
                onSubscribe: { print("开始订阅 infinite$")},
                onDispose: { print("销毁 infinite$")}
        )
        
        //一个有限序列（每隔0.5秒创建一个序列数，共创建三个 ）
        let limited$ = Observable<Int>
            .interval(0.5, scheduler: MainScheduler.instance)
            .take(2)
            .do(
                onNext: { print("limited$: \($0)") },
                onSubscribe: { print("开始订阅 limited$")},
                onDispose: { print("销毁 limited$")}
        )
    
        //使用using操作符创建序列
        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
            return AnyDisposable(infiniteInterval$.subscribe())
        }, observableFactory: { _ in return limited$ }
        )
        o.subscribe()
    
        
        
        
    }
    
    
class AnyDisposable: Disposable {
    
    let _dispose: () -> Void
    
    init(_ disposable: Disposable) {
        _dispose = disposable.dispose
    }
    
    func dispose() {
        _dispose()
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
