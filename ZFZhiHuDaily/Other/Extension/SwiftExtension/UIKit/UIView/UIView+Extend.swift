//
//  UIView+Extend.swift
//  SwiftPPT
//
//  Created by 成林 on 15/6/20.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    
    /**  size  */
    var size: CGSize { return self.bounds.size }
    
    /**  width  */
    var width: CGFloat { return self.size.width }
    
    /**  height  */
    var height: CGFloat { return self.size.height }
    
    
    /**  x  */
    var x: CGFloat {
        
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        
        get{
            return self.frame.origin.x
        }
    }
    
    /**  y  */
    var y: CGFloat {
        
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
        get{
            return self.frame.origin.y
        }
    }
    
    /**  添加边框  */
    func border(width width: CGFloat, color: UIColor){
        
        self.layer.borderWidth = width
        
        self.layer.borderColor = color.CGColor
    }
    
    class func viewInitWithNib() -> UIView{
        return NSBundle.mainBundle().loadNibNamed(stringFromClass(self)!, owner: nil, options: nil).first as! UIView
    }

    
}