//
//  APICommunicator.swift
//  MasterDetail
//
//  Created by Tomas Radvansky on 17/01/2017.
//  Copyright © 2017 Tomas Radvansky. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APICommunicator {
    static let sharedInstance = APICommunicator()
    private init() {} //This prevents others from using the default '()' initializer for this class.

    func getPostById(id:Int, completionHandler:@escaping (PostObject?, Error?) -> ())
    {
        let requestUrl = "\(WS_URL)/posts/\(id)"
        Alamofire.request(requestUrl).responseJSON { (response:DataResponse<Any>) in
            if let jsonObject:[String:Any] = response.result.value as? [String:Any] {
                completionHandler(PostObject(JSON: jsonObject), response.error)
            }
            else
            {
                completionHandler(nil, response.error)
            }
        }
    }
    
    func getPosts(offset:Int? = nil, limit:Int? = nil, completionHandler:@escaping ([PostObject]?, Error?) -> ()) {
        var requestUrl = "\(WS_URL)/posts"
        
        if (offset != nil || limit != nil)
        {
            //Implement paging + default values
            if let offsetValue:Int = offset
            {
                requestUrl = requestUrl + "?_start=\(offsetValue)"
            }
            else
            {
                requestUrl = requestUrl + "?_start=0"
            }
            
            if let limitValue:Int = limit
            {
                requestUrl = requestUrl + "&_limit=\(limitValue)"
            }
            else
            {
                requestUrl = requestUrl + "&_limit=\(DEFAULT_Limit)"
            }
        }
        
        Alamofire.request(requestUrl).responseJSON { (response:DataResponse<Any>) in
            if let jsonObject = response.result.value {
                let data:[PostObject]? = Mapper().mapArray(JSONObject: jsonObject)
                completionHandler(data, response.error)
            }
            else
            {
                completionHandler(nil, response.error)
            }
        }
    }
    
    func getUserById(id:Int, completionHandler:@escaping (UserObject?, Error?) -> ())
    {
        let requestUrl = "\(WS_URL)/users/\(id)"
        Alamofire.request(requestUrl).responseJSON { (response:DataResponse<Any>) in
            if let jsonObject:[String:Any] = response.result.value as? [String:Any] {
                completionHandler(UserObject(JSON: jsonObject), response.error)
            }
            else
            {
                completionHandler(nil, response.error)
            }
        }
    }
    
    func getCommentsByPostId(postId:Int, completionHandler:@escaping ([CommentObject]?, Error?) -> ())
    {
        let requestUrl = "\(WS_URL)/posts/\(postId)/comments"
        Alamofire.request(requestUrl).responseJSON { (response:DataResponse<Any>) in
            if let jsonObject = response.result.value {
                let data:[CommentObject]? = Mapper().mapArray(JSONObject: jsonObject)
                completionHandler(data, response.error)
            }
            else
            {
                completionHandler(nil, response.error)
            }
        }
       
    }
    
}
