//
//  Model.swift
//  tvJapan
//
//  Created by com on 2018/11/22.
//  Copyright © 2018 yyets. All rights reserved.
//

import ObjectMapper
import RxSwift

//豆瓣接口模型
class Douban: Mappable {
    //频道列表
    var channels: [Channel]?
    
    init(){
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        channels <- map["channels"]
    }
}

//频道模型
class Channel: Mappable {
    var name: String?
    var nameEn:String?
    var channelId: String?
    var seqId: Int?
    var abbrEn: String?
    
    init(){
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        nameEn <- map["name_en"]
        channelId <- map["channel_id"]
        seqId <- map["seq_id"]
        abbrEn <- map["abbr_en"]
    }
}

//歌曲列表模型
struct Playlist: Mappable {
    var r: Int!
    var isShowQuickStart: Int!
    var song:[Song]!
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        r <- map["r"]
        isShowQuickStart <- map["is_show_quick_start"]
        song <- map["song"]
    }
}

//歌曲模型
struct Song: Mappable {
    var title: String!
    var artist: String!
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        title <- map["title"]
        artist <- map["artist"]
    }
}


public enum RxObjectMapperError: Error{
    case parsingError
}

public extension Observable where Element: Any{
    
    //将JSON数据转成对象
    public func mapObject<T>(type: T.Type) -> Observable<T> where T: Mappable{
        let mapper = Mapper<T>()
        
        return self.map { (element) -> T in
            guard let parsedElement = mapper.map(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            
            return parsedElement
        }
    }
    
    
    public func mapArray<T>(type: T.Type) -> Observable<[T]> where T: Mappable{
        let mapper = Mapper<T>()
        
        return self.map{ (element) -> [T] in
            guard let parsedElement = mapper.mapArray(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            
            return parsedElement
        }
    }
}
