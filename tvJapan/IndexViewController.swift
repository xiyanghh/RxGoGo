//
//  ViewController.swift
//  tvJapan
//
//  Created by com on 2018/11/8.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class IndexViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var btn: UIButton!
    var scrollView: UIScrollView!
    
    var user: UILabel!
    @objc dynamic var uName = "zhang"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RxSwift"
        self.rx1_1()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func rx1_1(){
        
        self.btn = UIButton()
        self.btn.backgroundColor = .red
        self.view.addSubview(btn)
        self.btn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        //事件
        self.btn.rx.tap.subscribe(onNext: {
            print("123tap")
        }).disposed(by: disposeBag)
        
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = .yellow
        scrollView.contentSize = CGSize(width: kScreenWidth * 2, height: kScreenHeight * 2)
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(btn.snp.bottom).offset(10)
            make.centerX.width.height.equalTo(btn)
        }
        
        //代理
        scrollView.rx.contentOffset.subscribe(onNext: { (offsize) in
            print(offsize)
        }).disposed(by: disposeBag)
        
        
//        URLSession.shared.rx.data(request: URLRequest(url: NSURL(string: "http://www.baidu.com")! as URL)).subscribe(onNext: { (data) in
//            print(data)
//        }, onError: { (error) in
//            print(error)
//        }).disposed(by: disposeBag)
        
        
        //通知
        NotificationCenter.default.rx.notification(.UIApplicationWillEnterForeground).subscribe(onNext: { (notification) in
            print("333Enter")
        }).disposed(by: disposeBag)
        
//        //KVO
//        user.rx.observe(String.self, uName).subscribe(onNext: { (string) in
//
//        }).disposed(by: disposeBag)
        
        Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe(onNext: { [unowned self] _ in
            self.uName.append("!")
        }).disposed(by: disposeBag)
        
        _ = self.rx.observeWeakly(String.self, "uName").subscribe(onNext: { (string) in
          print(string!)
        })
        
        
    }
    
}

