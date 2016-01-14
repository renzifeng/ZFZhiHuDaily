//
//  XMNetworkTool.swift
//  baiduCourse
//
//  Created by 梁亦明 on 15/9/13.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

import Foundation
import JSONJoy
import Alamofire
import RxSwift
import Argo
import Moya

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
        if let parameters = params {
            Alamofire.request(.GET, httpUrl, parameters: parameters , encoding: .JSON, headers: nil).responseJSON(completionHandler: { (response) -> Void in
                if let JSON = response.result.value {
                    success(json: JSON)
                }
            })
        }else {
            Alamofire.request(.GET, httpUrl).responseJSON { (response) -> Void in
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
        
        let httpUrl : String = BASE_URL + url
        if let parameters = params {
            Alamofire.request(.POST, httpUrl, parameters: parameters, encoding: .JSON, headers: nil).responseJSON(completionHandler: { (response) -> Void in
                if let JSON = response.result.value {
                    success(json: JSON)
                }
            })
        }else {
            Alamofire.request(.POST, httpUrl).responseJSON { (response) -> Void in
                if let JSON = response.result.value {
                    success(json: JSON)
                }
            }
            
        }
    }
}

enum ORMError : ErrorType {
    case ORMNoRepresentor
    case ORMNotSuccessfulHTTP
    case ORMNoData
    case ORMCouldNotMakeObjectError
}

extension Observable {
    private func resultFromJSON<T: Decodable>(object:[String: AnyObject], classType: T.Type) -> T? {
        let decoded = classType.decode(JSON.parse(object))
        switch decoded {
        case .Success(let result):
            return result as? T
        case .Failure(let error):
            print("\(error)")
            return nil
            
        }
    }
    
    func mapSuccessfulHTTPToObject<T: Decodable>(type: T.Type) -> Observable<T> {
        return map { representor in
            guard let response = representor as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            guard ((200...209) ~= response.statusCode) else {
                if let json = try? NSJSONSerialization.JSONObjectWithData(response.data, options: .AllowFragments) as? [String: AnyObject] {
                    print("Got error message: \(json)")
                }
                throw ORMError.ORMNotSuccessfulHTTP
            }
            do {
                guard let json = try NSJSONSerialization.JSONObjectWithData(response.data, options: .AllowFragments) as? [String: AnyObject] else {
                    throw ORMError.ORMCouldNotMakeObjectError
                }
                return self.resultFromJSON(json, classType:type)!
            } catch {
                throw ORMError.ORMCouldNotMakeObjectError
            }
        }
    }
    
    func mapSuccessfulHTTPToObjectArray<T: Decodable>(type: T.Type) -> Observable<[T]> {
        return map { response in
            guard let response = response as? Moya.Response else {
                throw ORMError.ORMNoRepresentor
            }
            
            // Allow successful HTTP codes
            guard ((200...209) ~= response.statusCode) else {
                if let json = try? NSJSONSerialization.JSONObjectWithData(response.data, options: .AllowFragments) as? [String: AnyObject] {
                    print("Got error message: \(json)")
                }
                throw ORMError.ORMNotSuccessfulHTTP
            }
            
            do {
                guard let json = try NSJSONSerialization.JSONObjectWithData(response.data, options: .AllowFragments) as? [[String : AnyObject]] else {
                    throw ORMError.ORMCouldNotMakeObjectError
                }
                
                // Objects are not guaranteed, thus cannot directly map.
                var objects = [T]()
                for dict in json {
                    if let obj = self.resultFromJSON(dict, classType:type) {
                        objects.append(obj)
                    }
                }
                return objects
                
            } catch {
                throw ORMError.ORMCouldNotMakeObjectError
            }
        }
    }
}

