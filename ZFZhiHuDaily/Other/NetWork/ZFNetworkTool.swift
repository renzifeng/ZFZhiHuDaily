//
//  ZFNetworkTool.swift
//  baiduCourse
//
//  Created by 任子丰 on 15/9/13.
//  Copyright © 2015年 任子丰. All rights reserved.
//

import Foundation
import Alamofire

class ZFNetworkTool: NSObject {
    
    /**
    *   get方式获取数据
    *   url : 请求地址
    *   params : 传入参数
    *   success : 请求成功回调函数
    *   fail : 请求失败回调函数
    */
    
    static func get( url : String, params :[String : AnyObject]?, success :(json : AnyObject) -> Void , fail:(error : Any) -> Void) {
        let httpUrl : String = BASE_URL + url
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        if let parameters = params {
            Alamofire.request(.GET, httpUrl, parameters: parameters , encoding: .JSON, headers: nil).responseJSON(completionHandler: { (response) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if let JSON = response.result.value {
                    success(json: JSON)
                }
            })
        }else {
            Alamofire.request(.GET, httpUrl).responseJSON { (response) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if let JSON = response.result.value {
                    success(json: JSON)
                }
            }
            
        }
    }
    
    /**
    *   post方式获取数据
    *   url : 请求地址
    *   params : 传入参数
    *   success : 请求成功回调函数
    *   fail : 请求失败回调函数
    */
    
    static func post(url : String, params : [String : AnyObject]?, success:(json : Any) -> Void , fail:(error : Any) -> Void) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let httpUrl : String = BASE_URL + url
        if let parameters = params {
            Alamofire.request(.POST, httpUrl, parameters: parameters, encoding: .JSON, headers: nil).responseJSON(completionHandler: { (response) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if let JSON = response.result.value {
                    success(json: JSON)
                }
            })
        }else {
            Alamofire.request(.POST, httpUrl).responseJSON { (response) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if let JSON = response.result.value {
                    success(json: JSON)
                }
            }
            
        }
    }
    
}
