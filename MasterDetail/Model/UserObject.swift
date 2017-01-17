//
//  UserObject.swift
//  MasterDetail
//
//  Created by Tomas Radvansky on 17/01/2017.
//  Copyright © 2017 Tomas Radvansky. All rights reserved.
//

import Foundation
import ObjectMapper

class UserObject: Mappable {
    var id:Int?
    var name:String?
    var username:String?
    var email:String?
    var address:UserAddress?
    var phone:String?
    var website:String?
    var company:UserCompany?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        username        <- map["username"]
        email           <- map["email"]
        address         <- map["address"]
        phone           <- map["phone"]
        website         <- map["website"]
        company         <- map["company"]
    }
}

struct UserCompany: Mappable {
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name            <- map["name"]
        catchPhrase     <- map["catchPhrase"]
        bs              <- map["bs"]
    }
}

struct UserAddress: Mappable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: UserAddressGeo?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        street      <- map["street"]
        suite       <- map["suite"]
        city        <- map["city"]
        zipcode     <- map["zipcode"]
        geo         <- map["geo"]
    }
}

struct UserAddressGeo: Mappable {
    var lat: String?
    var lng: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        lat     <- map["lat"]
        lng     <- map["lng"]
    }
}
