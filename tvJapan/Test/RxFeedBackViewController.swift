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


extension Reactive where Base: UILabel{
    
    public var fontSize: Binder<CGFloat>{
        return Binder(self.base, binding: { (label, fontSize) in
            label.font = UIFont.systemFont(ofSize: fontSize)
        })
    }
    
    public var text: Binder<String?>{
        return Binder(self.base) { label, text in
            label.text = text
        }
    }
    
    public var attributedText: Binder<NSAttributedString?>{
        return Binder(self.base) { label, text in
            return label.attributedText = text
        }
    }
    
}


class RxFeedBackViewController: BaseViewController {
    
    var username: String = ""
    
    var userName =  Variable("aa")
    
    var inName: UILabel!
    
      let disposeBag =  DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()


        self.inName = UILabel()
        self.inName.backgroundColor = .red
        self.view.addSubview(inName)
        self.inName.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 30))
        }
        
//        _ = self.inName.rx.textInput <-> BehaviorRelay(value: userName) 未成功
//        self.userName.asObservable().bind(to: inName.rx.text).disposed(by: disposeBag)
//        self.inName.rx.text.orEmpty.bind(to: userName).disposed(by: disposeBag)
        
//        self.inName.rx.text.orEmpty
//            .map{ str in str.count }
//            .subscribe(onNext: { num in
//            print(num)
////            print("um = \(self.userName.value)")
//        }).disposed(by: disposeBag)
        
        
        
        
        
//        let observer: Binder<String> = Binder(inName) { (view, text) in
//            view.text = text
//        }
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map{ "当前索引数:\($0)" }
            .bind(to: inName.rx.text)
            .disposed(by: disposeBag)
        
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
//        let infiniteInterval$ = Observable<Int>
//            .interval(0.1, scheduler: MainScheduler.instance)
//            .do(
//                onNext: { print("infinite$: \($0)") },
//                onSubscribe: { print("开始订阅 infinite$")},
//                onDispose: { print("销毁 infinite$")}
//        )
//
//        //一个有限序列（每隔0.5秒创建一个序列数，共创建三个 ）
//        let limited$ = Observable<Int>
//            .interval(0.5, scheduler: MainScheduler.instance)
//            .take(2)
//            .do(
//                onNext: { print("limited$: \($0)") },
//                onSubscribe: { print("开始订阅 limited$")},
//                onDispose: { print("销毁 limited$")}
//        )
//
//        //使用using操作符创建序列
//        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
//            return AnyDisposable(infiniteInterval$.subscribe())
//        }, observableFactory: { _ in return limited$ }
//        )
//        o.subscribe()
    
        
        
        
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


