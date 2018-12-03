//
//  GitViewModel.swift
//  tvJapan
//
//  Created by com on 2018/11/16.
//  Copyright © 2018 yyets. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Result
import Moya_ObjectMapper

class GitViewModel {
    
    ///数据请求
    let netWorkService = GitHubNetWorkService()
    
    ///查询
//    fileprivate let searchAciton: Observable<String>
    fileprivate let searchAction: Driver<String>
    
    ///所有的查询结果
//    let searchResult: Observable<GitHubRepositories>
    let searchResult: Driver<GitHubRepositories>
    
    ///查询结果里的资源列表
//    let repositories: Observable<[GitHubRepository]>
    let repositories: Driver<[GitHubRepository]>
    
    ///清空结果
//    let cleanResult: Observable<Void>
    let cleanResult: Driver<Void>
    
    ///导航栏标题
//    let navigationTitle: Observable<String>
    let navigationTitle: Driver<String>
    
    init(searchAction: Driver<String>) {
        self.searchAction = searchAction
        
        //生成查询结果序列
//        self.searchResult = searchAction
//            .filter { !$0.isEmpty } //如果输入为空则不发送请求了
//            .flatMapLatest{
//                GitHubProvider.rx.request(.repositories($0))
//                    .filterSuccessfulStatusCodes()
//                    .mapObject(GitHubRepositories.self)
//                    .asDriver(onErrorDriveWith: Driver.empty())
//        }
        
        self.searchResult = searchAction
            .filter{ !$0.isEmpty }
            .flatMapLatest(netWorkService.searchRepositoriesDriver)
        
        
        self.cleanResult = searchAction.filter{ $0.isEmpty }.map{ _ in Void() }
        
        self.repositories = Driver.merge(
            searchResult.map{ $0.items },
            cleanResult.map{ [] })
        
        self.navigationTitle = Driver.merge(
            searchResult.map{ "共有 \($0.totalCount!) 个结果" },
            cleanResult.map{ "Rx" })
    }
    
    
//    init(searchAction: Observable<String>) {
//        self.searchAciton = searchAction
//
//        self.searchResult = searchAciton
//            .filter{ !$0.isEmpty }
//            .flatMapLatest{
//                GitHubProvider.rx.request(.repositories($0))
//                    .filterSuccessfulStatusCodes()
//                    .mapObject(GitHubRepositories.self)
//                    .asObservable()
//                    .catchError({ error in
//                        print("发生错误：",error.localizedDescription)
//                        return Observable<GitHubRepositories>.empty()
//                    })
//            }.share(replay: 1)
//
//
//        //生成清空结果动作序列
//        self.cleanResult = searchAction.filter{ $0.isEmpty }.map{ _ in Void() }
//
//        //生成查询结果里的资源列表序列（如果查询到结果则返回结果，如果是清空数据则返回空数组）
//        self.repositories = Observable.of(searchResult.map{ $0.items },
//                                          cleanResult.map{[]}).merge()
//
//
//        //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
//        self.navigationTitle = Observable.of(
//            searchResult.map{ "共有 \($0.totalCount!) 个结果" },
//            cleanResult.map{ "Rx" })
//            .merge()
//
//    }
    
}




