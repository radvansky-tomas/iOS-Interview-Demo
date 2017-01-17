//
//  ModelSpec.swift
//  MasterDetail
//  Sample Testing class
//  Created by Tomas Radvansky on 17/01/2017.
//  Copyright © 2017 Tomas Radvansky. All rights reserved.
//

import Foundation
import Quick
import Nimble
import ObjectMapper

class ModelSpec: QuickSpec {
    
    override func spec() {
        describe("Loading Data") {
            var filepath:String?
            
            beforeEach {
                //Load data
                let bundle = Bundle(for: type(of: self))
                filepath = bundle.path(forResource: "SamplePosts", ofType: "json")
            }
            
            it ("PostsParsing")
            {
                expect(filepath).notTo(beNil())
                
                let samplePosts:String? = try? String(contentsOfFile: filepath!)
                expect(samplePosts).notTo(beEmpty())
                
                let data:[PostObject]? = Mapper().mapArray(JSONString: samplePosts!)
                expect(data).notTo(beNil())
                expect(data?.count).to(equal(3))
                expect(data?[0].id).to(equal(1))
                expect(data?[0].body).to(equal("quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"))
                expect(data?[0].title).to(equal("sunt aut facere repellat provident occaecati excepturi optio reprehenderit"))
                expect(data?[0].userId).to(equal(1))
            }
        }
    }
}
