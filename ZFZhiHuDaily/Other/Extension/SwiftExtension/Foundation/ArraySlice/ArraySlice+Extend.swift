//
//  ArraySlice+Extend.swift
//  SwiftExtension
//
//  Created by 冯成林 on 15/6/10.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

extension ArraySlice{
    
    /** ArraySlice 转 Array */
    var array: Array<Element>{
        return Array(self)
    }
    
    
    
}