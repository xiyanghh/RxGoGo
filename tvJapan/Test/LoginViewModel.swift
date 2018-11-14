//
//  LoginViewModel.swift
//  tvJapan
//
//  Created by com on 2018/11/12.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewModel: NSObject {
    
    let usernameValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let everythingValid: Observable<Bool>
    
    init(
        username: Observable<String>,
        password: Observable<String>
        ){
        
        usernameValid = username
            .map{ $0.count >= 5 }
            .share(replay: 1)
        
        passwordValid = password
            .map{ $0.count >= 8}
            .share(replay: 1)
        
        everythingValid = Observable.combineLatest(usernameValid, passwordValid){ $0 && $1 }
            .share(replay: 1)
        
    }

}
