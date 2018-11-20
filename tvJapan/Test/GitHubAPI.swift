//
//  GitHubAPI.swift
//  tvJapan
//
//  Created by com on 2018/11/16.
//  Copyright © 2018 yyets. All rights reserved.
//

import Foundation
import Moya


public enum GitHubAPI{
    case repositories(String)
}

let GitHubProvider = MoyaProvider<GitHubAPI>()

extension GitHubAPI: TargetType{
    
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        print("发起请求。")
        switch self {
        case .repositories(let query):
            var params: [String: Any] = [:]
            params["q"] = query
            params["sort"] = "stars"
            params["order"] = "desc"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
    
}

