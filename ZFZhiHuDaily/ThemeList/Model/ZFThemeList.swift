//
//  ZFThemeList.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/11.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFThemeList  {
    /// 该主题日报的背景图片（大图）
    let background : String
    /// 颜色，作用未知
    let color : Int
    /// 该主题日报的介绍
    let description : String
    /// 背景图片的小图版本
    let image : String
    /// 图像的版权信息
    let image_source : String
    /// 该主题日报的名称
    let name : String
    /// 该主题日报的编辑
    let editors : [ThemeEditors]?
    /// 该主题日报中的文章列表
    let stories : [ThemeStories]?
    
    init(background : String, color : Int, description : String, image : String, image_source : String, name : String, editors : Array<ThemeEditors>?, stories : Array<ThemeStories>?){
        self.background = background
        self.color = color
        self.description = description
        self.image = image
        self.image_source = image_source
        self.name = name
        self.editors = editors
        self.stories = stories
    }
}

class ThemeEditors {
    /// 主编的头像
    let avatar : String
    /// 主编的个人简介
    let bio : String
    /// 数据库中的唯一表示符
    let id : Int
    /// 主编的姓名
    let name : String
    /// 主编的知乎用户主页
    let url : String
    init(avatar : String, bio : String, id : Int, name : String, url : String){
        self.avatar = avatar
        self.bio = bio
        self.id = id
        self.name = name;
        self.url = url
    }
}

class ThemeStories {
    /// 数据库中的唯一表示符
    var id : Int = 0
    /// 消息的标题
    let title : String
    /// 类型，作用未知
    let type : Int
    /// 图像地址（其类型为数组。请留意在代码中处理无该属性与数组长度为 0 的情况）
    let images : [String]
    
    init(id : Int, title : String , type : Int, images : [String]){
        self.id = id
        self.title = title
        self.type = type
        self.images = images
    }
}
