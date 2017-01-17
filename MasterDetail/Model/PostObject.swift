//
//  PostObject.swift
//  MasterDetail
//
//  Created by Tomas Radvansky on 17/01/2017.
//  Copyright © 2017 Tomas Radvansky. All rights reserved.
//

import Foundation
import ObjectMapper

class PostObject: Mappable {
    var userId:Int?
    var id:Int?
    var title:String?
    var body:String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        userId      <- map["userId"]
        id          <- map["id"]
        title       <- map["title"]
        body        <- map["body"]
    }
}
