//
//  GitHubNetWorkService.swift
//  tvJapan
//
//  Created by com on 2018/11/16.
//  Copyright © 2018 yyets. All rights reserved.
//

import RxCocoa
import RxSwift
import ObjectMapper

class GitHubNetWorkService {
    
    func searchRepositoriesDriver(query: String) -> Driver<GitHubRepositories>{
        
        return GitHubProvider.rx.request(.repositories(query))
                .filterSuccessfulStatusCodes()
                .mapObject(GitHubRepositories.self)
                .asDriver(onErrorDriveWith: Driver.empty())
    }
    
    
    //MARK: Observable
    
//    func searchRepositories(query: String) -> Observable<GitHubRepositories>{
//
//        return GitHubProvider.rx.request(.repositories(query))
//            .filterSuccessfulStatusCodes()
//            .mapObject(GitHubRepositories.self)
//            .asObservable()
//            .catchError({ (error) -> Observable<GitHubRepositories> in
//                return Observable<GitHubRepositories>.empty()
//            })
//    }
    
//    func searchRepositories(query:String) -> Observable<GitHubRepositories> {
//        return GitHubProvider.rx.request(.repositories(query))
//            .filterSuccessfulStatusCodes()
//            .mapObject(GitHubRepositories.self)
//            .asObservable()
//            .catchError({ error in
//                print("发生错误：",error.localizedDescription)
//                return Observable<GitHubRepositories>.empty()
//            })
//    }
    
}

