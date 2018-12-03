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

enum DataError: Error {
    case cantParseJSON
}


//public static func system<State, Event>(
//    initialState: State,
//    reduce: @escaping (State, Event) -> State,
//    feedback: (Observable<State>) -> Observable<Event>...
//    ) -> Observable<State>


class RxFeedBackViewController: BaseViewController {
    
    var username: String = ""
    
    var userName =  Variable("aa")
    
    var inName: UILabel!
    
    let disposeBag =  DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        getPlaylist("0")
//            .subscribe { (event) in
//                switch event{
//                case .success(let json):
//                    print("结果 = \(json)")
//                case .error(let error):
//                    print("错误 = \(error)")
//                }
//        }
//            .disposed(by: disposeBag)
        
        
        //MARK: ERROR
        //1，catchErrorJustReturn
        //当遇到 error 事件的时候，就返回指定的值，然后结束。
        
//        let sequenceThatFails = PublishSubject<String>()
        
//        sequenceThatFails
//            .catchErrorJustReturn("错误")
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        
        //2，catchError
        //该方法可以捕获 error，并对其进行处理。
        //同时还能返回另一个 Observable 序列进行订阅（切换到新的序列）。
        
//        let recoverySequence = Observable.of("1","2","3")
//        sequenceThatFails
//            .catchError {
//                print($0)
//                return recoverySequence
//        }
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        
        
        
        

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
//            .debug()
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
    
    //获取豆瓣某频道下的歌曲信息
    func getPlaylist(_ channel: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { single in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data,
                                                                 options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                
                single(.success(result))
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
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
