//
//  AppDelegate+Extend.swift
//  WelCome
//
//  Created by 冯成林 on 15/7/7.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate{


    /** 扩展AppDelegate的window初始化 */
    func appDelegatePrepare(){
        
        let window = UIWindow(frame: Screen.bounds)
        
        //设置窗口颜色
        window.backgroundColor = UIColor.whiteColor()
        
        //设置主window
        self.window = window
        
        //设置根控制器
        window.rootViewController = window.rootVCPrepare()
        
        //窗口成为主窗口并激活
        window.makeKeyAndVisible()
    }
    

}