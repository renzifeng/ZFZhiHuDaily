//
//  ZFAppConfig.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/4.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

struct Keys {
    static let launchImgKey = "launchImgKey"
    static let launchTextKey = "launchTextKey"
    static let readNewsId = "readNewsId"
}
typealias ErrorBlockCallBack = (error : NSError) -> Void
// MARK: - 主页上得各种高度的变量
/// 100
let TABLE_CELL_HEIGHT : Float = 100
/// 24
let SECTION_HEIGHT:Float = 24
/// 80
let SCROLL_HEIGHT:Float = 80
/// 400
let IMAGE_HEIGHT:Float = IN_WINDOW_HEIGHT+200
/// 200
let IN_WINDOW_HEIGHT:Float = UIScreen.mainScreen().bounds.height > 1000 ? 300 : 200
/// 44
let TITLE_HEIGHT:Float = 44
// MARK: - 获取SB
func GET_SB (sbName : String) -> UIStoryboard {
    return UIStoryboard(name: sbName, bundle: NSBundle.mainBundle())
}

let App_Delagate = UIApplication.sharedApplication().delegate as! AppDelegate

// MARK: - 屏幕宽高
let ScreenWidth : CGFloat = UIScreen.mainScreen().bounds.width
let ScreenHeight : CGFloat = UIScreen.mainScreen().bounds.height

// MARK: - 颜色
func RGBA (r:CGFloat,_ g:CGFloat, _ b:CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func RGB (r:CGFloat,_ g:CGFloat, _ b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

//主题蓝色
let ThemeColor = RGB(0, 130, 210)

//延时操作
func GCD_Delay (second : NSTimeInterval ) -> dispatch_time_t {
    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(second * Double(NSEC_PER_SEC)))
    return delay
}

func FONT (size : CGFloat) -> UIFont {
    return UIFont.systemFontOfSize(size)
}

