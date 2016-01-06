//
//  UIDevice.swift
//  WelCome
//
//  Created by 冯成林 on 15/7/10.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit

/** 硬件检测 */

/** 是否是iPhone 4系列 */
func iPhone4x_320_480() -> Bool{
    return isDevice(width: 320, height: 480)
}

/** 是否是iPhone 5系列 */
func iPhone5x_320_568() -> Bool{
    return isDevice(width: 320, height: 568)
}

/** 是否是iPhone 6 */
func iPhone6_375_667() -> Bool{
    return isDevice(width: 375, height: 667)
}

/** 是否是iPhone 6 Plus */
func iPhone6Plus_414_736_Portait() -> Bool{
    return isDevice(width: 414, height: 736)
}

/** 通用方法 */
func isDevice(width width: CGFloat, height: CGFloat) -> Bool{
    return Screen.width == width && Screen.height == height
}








/** 软件检测 */

/** 是否是iOS 7 */
func iOS7() -> Bool{
    return (UIDevice.versionValue >= 7.0) && (UIDevice.versionValue < 8.0)
}

/** 是否是iOS 8 */
func iOS8() -> Bool{
    return (UIDevice.versionValue >= 8.0) && (UIDevice.versionValue < 9.0)
}

/** 是否是iOS 9 */
func iOS9() -> Bool{
    return (UIDevice.versionValue >= 9.0) && (UIDevice.versionValue < 10.0)
}

extension UIDevice{
    static var versionValue: Float {return (UIDevice.currentDevice().systemVersion as NSString).floatValue}
}





















