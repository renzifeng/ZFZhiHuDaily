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
            
            var lenth = self.count
        
            range = Range(start: 0, end: lenth)
        }
        
        return self[range];
    }
    
    
    /** 仿OC遍历 */
    func enumerate(itemClosure: (index: Int , value: Element)->Void){
        
        for (var i=0;i<self.count;i++){
            
            itemClosure(index: i, value: self[i])
        }
    }
    
    
    
    
    
    
    
    
    
    
}


