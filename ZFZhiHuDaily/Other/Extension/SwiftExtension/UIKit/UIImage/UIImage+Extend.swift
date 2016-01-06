//
//  UIImage+Extend.swift
//  CFPPTView
//
//  Created by 成林 on 15/6/21.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//


import UIKit

extension UIImage {
    
    /** 图片着色 */
    func imageWithTintColor(tintColor: UIColor)->UIImage{
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        
        tintColor.setFill()
    
        let bounds = CGRectMake(0, 0, self.size.width, self.size.height)
        
        UIRectFill(bounds)
        
        self.drawInRect(bounds, blendMode: CGBlendMode.DestinationIn, alpha: 1.0)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
    
    
    /** 颜色构造图像 */
    //给我一种颜色，一个尺寸，我给你返回一个UIImage
    class func imageBuildWithColor(color: UIColor, size: CGSize?, isRound: Bool) -> UIImage{
        
        let imgSize = size ?? CGSizeMake(1, 1)
    
        let rect=CGRectMake(0, 0, imgSize.width, imgSize.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        let context=UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        
        if isRound {CGContextFillEllipseInRect(context, rect)}else{CGContextFillRect(context, rect)}
        
        let image=UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
