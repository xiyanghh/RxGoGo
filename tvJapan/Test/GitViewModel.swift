//
//  GitViewModel.swift
//  tvJapan
//
//  Created by com on 2018/11/16.
//  Copyright © 2018 yyets. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya_ObjectMapper


//class GitViewModel {
//    
//    ///数据请求
//    let netWorkService = GitHubNetWorkService()
//    
//    ///查询
//    fileprivate let searchAction: Driver<String>
//    
//    ///所有的查询结果
//    let searchResult: Driver<GitHubRepositories>
//    
//    ///查询结果里的资源列表
//    let repositories: Driver<[GitHubRepositories]>
//    
//    ///清空结果
//    let cleanResult: Driver<Void>
//    
//    ///导航栏标题
//    let navigationTitle: Driver<String>
//    
//
//    
//}
    

    
    ///初始化
//    init(searchAction: Driver<String>) {
//        self.searchAction = searchAction
//        
//        self.searchResult = searchAction
//            .filter { !$0.isEmpty } //如果输入为空则不发送请求了
//            .flatMapLatest{ [weak self] in (self?.netWorkService.searchRepositories(query: $0))!  }
//
//        self.cleanResult = searchAction.filter{ $0.isEmpty }.map{ _ in Void() }
//
//        self.repositories = Driver.merge(
//            searchResult.map{ $0.items },
//            cleanResult.map{ [] })
//
//        self.navigationTitle = Driver.merge(
//            searchResult.map{ "共有\($0.totalCount!)个结果" },
//            cleanResult.map{ "Rx" })
//    }

