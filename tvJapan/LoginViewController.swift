//
//  LoginViewController.swift
//  tvJapan
//
//  Created by com on 2018/11/9.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {

    @IBOutlet weak var uName: UILabel!
    @IBOutlet weak var uPwd: UILabel!
    
    @IBOutlet weak var inName: UITextField!
    @IBOutlet weak var inPwd: UITextField!
    
    @IBOutlet weak var Done: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let usernameValid = inName.rx.text.orEmpty
            // 用户名 -> 用户名是否有效
            .map { $0.count >= 5 }
            .share(replay: 1)
        
        let passwordValid = inPwd.rx.text.orEmpty
            .map { $0.count >= 8 }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(
            usernameValid,
            passwordValid)
            { $0 && $1}
            .share(replay: 1)
        
        usernameValid
            .bind(to: inPwd.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: uName.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: uPwd.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: Done.rx.isEnabled)
            .disposed(by: disposeBag)
        
        Done.rx.tap.subscribe(onNext: { [weak self] in self?.showAlert()})
            .disposed(by: disposeBag)

    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
