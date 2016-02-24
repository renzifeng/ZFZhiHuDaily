//
//  ZFAppConfig.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/6.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

struct Keys {
    static let launchImgKey = "launchImgKey"
    static let launchTextKey = "launchTextKey"
    static let readNewsId = "readNewsId"
}
typealias ErrorBlockCallBack = (error : NSError) -> Void

// MARK: - 获取SB
func GET_SB (sbName : String) -> UIStoryboard {
    return UIStoryboard(name: sbName, bundle: NSBundle.mainBundle())
}

let App_Delagate = UIApplication.sharedApplication().delegate as! AppDelegate

func LightStatusBar() {
    UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
}
func BlackStatusBar() {
   UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
}

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


// 切圆角
func cutRoundWith(view : UIView) {
    let corner = view.width/2
    let shapeLayer = CAShapeLayer()
    let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .AllCorners, cornerRadii:CGSizeMake(corner,corner))
    shapeLayer.path = path.CGPath
    view.layer.mask = shapeLayer
}

