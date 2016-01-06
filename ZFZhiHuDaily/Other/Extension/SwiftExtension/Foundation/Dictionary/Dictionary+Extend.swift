//
//  Dictionary+Extend.swift
//  SwiftExtension
//
//  Created by 冯成林 on 15/6/10.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


extension Dictionary{
    
    /** 仿OC遍历 */
    func enumerate(itemClosure: (index: Int, key: Key, value: Value)->Void){
        
        var i = 0
        for (key,value) in self{
            itemClosure(index:i,key: key, value: value)
            i++
        }
    }

}