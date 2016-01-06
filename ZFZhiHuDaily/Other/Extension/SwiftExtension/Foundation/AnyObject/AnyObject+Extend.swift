//
//  AnyObject+Extend.swift
//  SwiftExtension
//
//  Created by 冯成林 on 15/6/9.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

/** 获取对象内存地址 */
func ObjectPointerAddress<T : AnyObject> ( obj : T ) -> String{
    
    return NSString(format: "%p",unsafeBitCast(obj, Int.self)) as String
}



