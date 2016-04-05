//
//  Array+Extend.swift
//  SwiftExtension
//
//  Created by 冯成林 on 15/6/10.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

extension Array{
    
    /** Array 转 ArraySlice */
    func slice(openOrClosedInterval: Range<Int>) -> ArraySlice<Element>{
        
        var range = openOrClosedInterval
        
        if openOrClosedInterval.isEmpty {
            
            let lenth = self.count

            range = Range(0..<lenth)
        }
        
        return self[range];
    }
    
    
    /** 仿OC遍历 */
    func enumerate(itemClosure: (index: Int , value: Element)->Void){
        
        for i in 0 ..< self.count {
            
            itemClosure(index: i, value: self[i])
        }
    }
    
    
    
    
    
    
    
    
    
    
}


