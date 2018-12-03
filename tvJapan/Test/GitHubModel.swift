//
//  GitHubModel.swift
//  tvJapan
//
//  Created by com on 2018/11/16.
//  Copyright © 2018 yyets. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya_ObjectMapper

struct GitHubRepositories: Mappable{

    var totalCount: Int!
    var incompleteResults: Bool!
    var items: [GitHubRepository]!
    
    init(){
        totalCount = 0
        incompleteResults = false
        items = []
    }
    
    init?(map: Map){  }

    mutating func mapping(map: Map) {
    
        totalCount <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items <- map["items"]
        
    }
    
}


struct GitHubRepository: Mappable {
    
    var id: Int!
    var name: String!
    var fullName: String!
    var htmlUrl: String!
    var description: String!
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullName <- map["full_name"]
        htmlUrl <- map["html_url"]
        description <- map["description"]
    }
    
}


