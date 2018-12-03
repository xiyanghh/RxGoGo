//
//  FuncViewController.swift
//  tvJapan
//
//  Created by com on 2018/11/20.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import Alamofire
import RxAlamofire


enum CacheError: Error {
    case failedCaching
}


class FuncViewController: BaseViewController {
    
    let disposeBag =  DisposeBag()
    
    var inputName: UITextField!
    
    var ctimer: UIDatePicker!
    var btnstart: UIButton!
    
    let leftTime = Variable(TimeInterval(180))
    
    let countDownStoped = Variable(true)
    
    let urlString = "https://www.douban.com/j/app/radio/channels"
    
    
    var tableView:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.funcAlamofire()
//        self.funcSession()
//        self.funcTable()
//        self.funcGesture()
//        self.funcActivityIndicator()
//        self.funcButton()
//        self.funcText()
//        self.funcLabel()
//        self.funcCompletable()
    }
    
    func funcUpload(){
        
        let file = Bundle.main.url(forResource: "1", withExtension: "png")
        let url = URL(string: "http://www")
   
        upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(file!, withName: "png")
        }, to: url!) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON{ res in
                    debugPrint(res)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func funcAlamofire(){
        
        let url = URL(string: urlString)
        
//        request(.get, url!)
//            .data()
//            .subscribe(onNext: { (data) in
//                let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String : Any]
//                print(json!)
//            }).disposed(by: disposeBag)
        
//        requestData(.get, url!)
//            .subscribe(onNext: { (response, data) in
//            let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String : Any]
//            print(json!)
//        }).disposed(by: disposeBag)
        
//        request(.get, url!)
//            .responseJSON()
//            .subscribe(onNext: { (res) in
//                print(res.value!)
//            }).disposed(by: disposeBag)
        
        requestJSON(.get, url!)
            .map{$1}
            .mapObject(type: Douban.self)
            .subscribe(onNext: { (douban) in
                if let channels = douban.channels{
                    print("共\(channels.count)个频道")
                    for channel in channels{
                        if let name = channel.name, let channelId = channel.channelId {
                            print("\(name) （id:\(channelId)）")
                        }
                    }
                }
            }).disposed(by: disposeBag)
        
    }
    
    func funcSession(){
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
//        URLSession.shared.rx.response(request: request).subscribe(onNext: { (response, data) in
//            if 200 ..< 300 ~= response.statusCode {
//
//            }else{
//                let str = String(data: data, encoding: String.Encoding.utf8)
//                print(str!)
//            }
//        }).disposed(by: disposeBag)
        
//        URLSession.shared.rx.data(request: request).subscribe(onNext: { (data) in
//
//            let json = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String : Any]
//            print(json)
//        }, onError: { (error) in
//
//        })
//        .disposed(by: disposeBag)
//
//        URLSession.shared.rx.json(request: request).subscribe(onNext: { (json) in
//
//            print(json)
//
//        }).disposed(by: disposeBag)
        
        URLSession.shared.rx.json(request: request)
            .mapObject(type: Douban.self)
            .subscribe(onNext: { (douban) in
                if let channels = douban.channels{
                    print("共\(channels.count)个频道")
                    for channel in channels{
                        if let name = channel.name, let channelId = channel.channelId {
                            print("\(name) （id:\(channelId)）")
                        }
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    func funcTable(){
        
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        
        
        
        let items = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
            ])
        
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(row)：\(element)"
                return cell
            }
            .disposed(by: disposeBag)
        
        
    }
    
    
    func funcDatePicker(){
        
        ctimer = UIDatePicker(frame:CGRect(x:0, y:80, width:320, height:200))
        ctimer.datePickerMode = UIDatePickerMode.countDownTimer
        self.view.addSubview(ctimer)
        
        btnstart =  UIButton(type: .system)
        btnstart.frame = CGRect(x:0, y:300, width:320, height:30);
        btnstart.setTitleColor(UIColor.red, for: .normal)
        btnstart.setTitleColor(UIColor.darkGray, for:.disabled)
        self.view.addSubview(btnstart)
        
        
    }
    
    func funcGesture(){
        
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        swipe.rx.event
            .subscribe(onNext: { [weak self] gesture in
                let point = gesture.location(in: gesture.view)
                self?.showMessage("向上滑动,\(point.x) \(point.y)")
            })
            .disposed(by: disposeBag)
        
    }
    
    func funcActivityIndicator(){
        
        let switchk = UISwitch(frame: CGRect(x: 20, y: 100, w: 40, h: 30))
        self.view.addSubview(switchk)
        
        let act = UIActivityIndicatorView(frame: CGRect(x: 70, y: 100, w: 30, h: 30))
        act.backgroundColor = .red
        self.view.addSubview(act)
        
        switchk.rx.value
            .bind(to: act.rx.isAnimating)
            .disposed(by: disposeBag)
        
        switchk.rx.value
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
    }
    
    
    func funcButton(){
        
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:100, width:40, height:30)
        button.setTitle("提交1", for:.normal)
        button.isSelected = true
        self.view.addSubview(button)
        
        let button2:UIButton = UIButton(type:.system)
        button2.frame = CGRect(x:20, y:200, width:40, height:30)
        button2.setTitle("提交2", for:.normal)
        self.view.addSubview(button2)
        
        let button3:UIButton = UIButton(type:.system)
        button3.frame = CGRect(x:20, y:300, width:40, height:30)
        button3.setTitle("提交3", for:.normal)
        self.view.addSubview(button3)
        
        let buttons = [button, button2, button3].map{ $0! }

        let selectBtn = Observable.from(
            buttons.map{
                button in button.rx.tap.map {
                    button } } ).merge()
        
        for button in buttons{
            selectBtn.map{ $0 == button }
                .bind(to: button.rx.isSelected)
                .disposed(by: disposeBag)
        }
        
//        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
//        timer.map(formatTimeInterval)
//            .bind(to: button.rx.attributedTitle())
//            .disposed(by: disposeBag)
        
//        timer.map { "计数 \($0)"}
//            .bind(to: button.rx.title(for: .normal))
//            .disposed(by: disposeBag)
        
        
//        button.rx.tap
//            .subscribe(onNext: { [weak self] in
//                self?.showMessage("点击")
//            })
        
        
    }
    
    func showMessage(_ text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func funcText(){
        
        let inputTx = UITextField(frame: CGRect(x: 10, y: 80, w: 200, h: 30))
        inputTx.borderStyle = .roundedRect
        self.view.addSubview(inputTx)
        
        let outputTx = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        outputTx.borderStyle = UITextBorderStyle.roundedRect
        self.view.addSubview(outputTx)
        
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        self.view.addSubview(label)
        
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:230, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        Observable.combineLatest(inputTx.rx.text.orEmpty, outputTx.rx.text.orEmpty) { (v1, v2) -> String in
            return "输入的号码: \(v1)-\(v2)"
        }
            .map{ $0 }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        
        
//        let input = inputTx.rx.text.orEmpty.asDriver().throttle(0.3)
        
//        input.drive(outputTx.rx.text)
//            .disposed(by: disposeBag)
        
//        input.map { "当前字数: \($0.count)" }
//            .drive(label.rx.text)
//            .disposed(by: disposeBag)
        
//        input.map { $0.count > 5 }
//            .drive(button.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        
//        inputTx.rx.text.orEmpty.asObservable()
//            .subscribe( onNext: {
//                print($0)
//            } )
//            .disposed(by: disposeBag)
        
    }
    
    
    func funcLabel(){
        
        let label = UILabel(frame: CGRect(x: 20, y: 40, w: 300, h: 100))
        self.view.addSubview(label)
        
        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
//        timer.map { String(format: "%0.2d:%0.2d.%0.1d",
//                           arguments: [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10])
//        }
                timer.map( formatTimeInterval )
                .bind(to: label.rx.attributedText)
                .disposed(by: disposeBag)
        
    }
    
    func formatTimeInterval(ms: NSInteger) -> NSMutableAttributedString{
        let string  = String(format: "%0.2d:%0.2d.%0.1d",
                             arguments: [(ms / 600) % 600, (ms % 600 ) / 10, ms % 10])
        
        let attributeString = NSMutableAttributedString(string: string)
        
        let keyValue = [NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-Bold", size: 16),
                        NSAttributedStringKey.foregroundColor : UIColor.white,
                        NSAttributedStringKey.backgroundColor : UIColor.orange]
        
        attributeString.addAttributes(keyValue as [NSAttributedStringKey : Any], range: NSMakeRange(0, 5))
        
        return attributeString
        
    }
    

    
    func funcCompletable(){
        
        cacheLocally()
            .subscribe(onCompleted: {
                print("保存成功!")
            }, onError: { error in
                print("保存失败: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
        
    }
    

    //将数据缓存到本地
    func cacheLocally() -> Completable {
        return Completable.create { completable in
            //将数据缓存到本地（这里掠过具体的业务代码，随机成功或失败）
            let success = (arc4random() % 2 == 0)
            
            guard success else {
                completable(.error(CacheError.failedCaching))
                return Disposables.create {}
            }
            
            completable(.completed)
            return Disposables.create {}
        }
    }


}
