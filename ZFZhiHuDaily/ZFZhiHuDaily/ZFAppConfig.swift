//
//  ZFAppConfig.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/4.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
// MARK: - 屏幕宽高
let ScreenWidth : CGFloat = UIScreen.mainScreen().bounds.width
let ScreenHeight : CGFloat = UIScreen.mainScreen().bounds.height

// MARK: - 颜色
func RGBA (r:CGFloat,_ g:CGFloat, _ b:CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
