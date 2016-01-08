//
//  NavigationBarExtension.swift
//  ParallaxHeaderView
//
//  Created by wl on 15/11/5.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

var key: String = "coverView"

extension UINavigationBar {
    
    /// 定义的一个计算属性，如果可以我更希望直接顶一个存储属性。它用来返回和设置我们需要加到
    /// UINavigationBar上的View
    var coverView: UIView? {
        get {
            //这句的意思大概可以理解为利用key在self中取出对应的对象,如果没有key对应的对象就返回niu
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        
        set {
            //与上面对应是重新设置这个对象，最后一个参数如果学过oc的话很好理解，就是代表这个newValue的属性
            //OBJC_ASSOCIATION_RETAIN_NONATOMIC意味着:strong,nonatomic
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setMyBackgroundColor(color: UIColor) {
        
        if self.coverView != nil {
            self.coverView!.backgroundColor = color
        }else {
            self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.shadowImage = UIImage()
            let view = UIView(frame: CGRectMake(0, -20, UIScreen.mainScreen().bounds.size.width, CGRectGetHeight(self.bounds) + 20))
            view.userInteractionEnabled = false
            view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            self.insertSubview(view, atIndex: 0)
            
            view.backgroundColor = color
            self.coverView = view
        }
    }
    
    func setMyBackgroundColorAlpha(alpha: CGFloat) {
        
        guard let coverView = self.coverView else {
            return
        }
        self.coverView!.backgroundColor = coverView.backgroundColor?.colorWithAlphaComponent(alpha)
    }
}
