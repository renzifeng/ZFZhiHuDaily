//
//  UIWindow+AppDelegate.swift
//  WelCome
//
//  Created by 冯成林 on 15/7/10.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    /** 这些返回内容，每个APP是不一样的 */
    /** 返回根控制器 */
    func rootVCPrepare()->UIViewController{
        
//        //测试
//        let testVC = AppNavVC(rootViewController: OrderDetail.controllerInitWithNib())
//        return testVC
        
        return self.determinedRootVC()
    }
    
    /** 考虑版本新特性页面，在这里决定返回的具体的控制器 */
    func determinedRootVC()->UIViewController{

        return UIViewController();
    }
    
    
    /** 切换控制器 */
    func toggleRootVC(){
        
        //设置根控制器
        self.rootViewController = self.rootVCPrepare()
    }

    
}


