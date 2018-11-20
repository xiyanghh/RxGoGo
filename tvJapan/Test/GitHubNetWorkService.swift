//
//  GitHubNetWorkService.swift
//  tvJapan
//
//  Created by com on 2018/11/16.
//  Copyright © 2018 yyets. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import ObjectMapper
import Moya_ObjectMapper


class GitHubNetWorkService {
    
    func searchRepositories(query: String) -> Driver<GitHubRepositories>{
        
//        return GitHubProvider.rx.request(.repositories(query))
//                .filterSuccessfulStatusAndRedirectCodes()
//                .mapJSON().asDriver(onErrorDriveWith: Driver.empty())
        
        return Driver.empty()
        
    }
    
}

