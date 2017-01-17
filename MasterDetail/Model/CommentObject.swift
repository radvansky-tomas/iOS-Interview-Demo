//
//  CommentObject.swift
//  MasterDetail
//
//  Created by Tomas Radvansky on 17/01/2017.
//  Copyright © 2017 Tomas Radvansky. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentObject: Mappable {
    var postId:Int?
    var id:Int?
    var name:String?
    var email:String?
    var body:String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        postId      <- map["postId"]
        id          <- map["id"]
        name        <- map["name"]
        email       <- map["email"]
        body        <- map["body"]
    }
}
