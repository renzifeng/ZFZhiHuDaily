//
//  ZFMain.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/7.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

struct ZFNews {
    /// 列表缩略图, 可能没有
    let images : [String]?
    
    /// 标题
    let title : String
    
    /// 类型,作用未知
    let type : Int = 0
    
    /// 新闻ID
    let new_id :Int
    
    /// 无用
    let gaPrefix : Int?
    
    /// 多图的标志
    let multipic : Bool
    
    /// 是否已读的标志
    var alreadyRead = false
    
    init(id:Int,title:String,images:[String]? = nil,multipic:Bool? = false,gaPrefix:Int? = nil) {
        self.new_id = id
        self.title = title
        self.images = images
        self.multipic = multipic ?? false
        self.gaPrefix = gaPrefix
    }

}
