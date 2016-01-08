//  由于IOS9 废弃了NSURLConnection.sendSynchronousRequest:returningResponse: 这几个方法,推荐实用NSURLSession来实现.
//  又由于我这里必须实用同步的调用,因此,给NSURLSession写了一个扩展, 增加了两个synchronous同步的方法.
//  NSURLSession+SynchronousTask.swift
//  ZhiHuDaily-Swift
//
//  Created by SUN on 15/7/13.
//  Copyright © 2015年 SUN. All rights reserved.
//

import Foundation

extension NSURLSession {
    
    func sendSynchronousDataTaskWithRequest(request:NSURLRequest) throws -> NSData?{
        var response:NSURLResponse? = nil
        return try self.sendSynchronousDataTaskWithRequest(request, returningResponse: &response)
    }
    
    func sendSynchronousDataTaskWithRequest(request:NSURLRequest,inout returningResponse response:NSURLResponse?) throws -> NSData?{
        
        let semaphore:dispatch_semaphore_t = dispatch_semaphore_create(0)
        
        var data:NSData? = nil
        
        var error:NSError? = nil
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (taskData, taskResponse, taskError) -> Void in
            data = taskData
            
            if let _response = taskResponse {
                response = _response
            }
            
            error = taskError
            
            dispatch_semaphore_signal(semaphore);
        }.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        if let _error = error {
            //异常
            throw AppException.Other(_error.description)
        }
        
        return data
    }
    
    func sendSynchronousDataTaskWithURL(url:NSURL) throws -> NSData?{
     
        var response:NSURLResponse? = nil
        
        return try self.sendSynchronousDataTaskWithURL(url, returningResponse: &response)
        
    }
    
    func sendSynchronousDataTaskWithURL(url:NSURL,inout returningResponse response:NSURLResponse?) throws -> NSData?{
        let semaphore:dispatch_semaphore_t = dispatch_semaphore_create(0)
        
        var data:NSData? = nil
        
        var error:NSError? = nil
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { (taskData, taskResponse, taskError) -> Void in
            data = taskData
            if let _response = taskResponse {
                response = _response
            }
            
            error = taskError
            
            dispatch_semaphore_signal(semaphore);
        }.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        if let _error = error {
            //异常
            throw AppException.Other(_error.description)
        }
        
        return data
    }
    
}