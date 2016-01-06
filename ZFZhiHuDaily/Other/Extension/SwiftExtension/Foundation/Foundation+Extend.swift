//
//  Foundation+Extend.swift
//  SwiftExtension
//
//  Created by 冯成林 on 15/6/10.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit

/** 宏定义 */

/** BOOL值 */
let YES = true
let NO = false

/** 零区间 */
let RangeIntervalZero = 0..<0


/**  方向定义  */
enum Direction {
    
    //上
    case Top
    
    //左
    case Left
    
    //下
    case Bottom
    
    //右
    case Right
}

/**  对Int扩展  */
extension Int{
    
    var toCGFloat: CGFloat { return CGFloat(self) }
}

/**  对CGFlout扩展  */
extension CGFloat {
    var toInt: Int { return Int(self) }
}


extension NSObject {
    
    var classNameAsString: String{
        return NSStringFromClass(self.classForCoder).componentsSeparatedByString(".").last!
    }
}


func stringFromClass(cls: AnyClass)->String?{
    
    let string = NSStringFromClass(cls.self).componentsSeparatedByString(".").last
    
    return string
}



/** OC与Swift字典与数组互转 */

/** id转Dictionary? */
func objectConvertToDictionay(obj: AnyObject!)->[NSObject: AnyObject]?{
    
    if obj == nil {print("注意：OC原字典为空"); return nil}
    
    return obj as? [NSObject: AnyObject]! as Dictionary?
}

/** id转Array? */
func objectConvertToArray(obj: AnyObject!)->[AnyObject]?{
    
    if obj == nil {print("注意：OC原数组为空"); return nil}
    
    return obj as? [AnyObject]! as Array?
}



/** 扩展可计算类型的混合运算 */
protocol CanCalProtocol{}
extension Int: CanCalProtocol{}
extension Float: CanCalProtocol{}
extension CGFloat: CanCalProtocol{}
extension Double: CanCalProtocol{}

/** + */
func +(left:CanCalProtocol, right:CanCalProtocol) -> Double{
    return CanCalProtocol2Double(left) + CanCalProtocol2Double(right)
}

/** - */
func -(left:CanCalProtocol, right:CanCalProtocol) -> Double{
    return CanCalProtocol2Double(left) - CanCalProtocol2Double(right)
}

/** * */
func *(left:CanCalProtocol, right:CanCalProtocol) -> Double{
    return CanCalProtocol2Double(left) * CanCalProtocol2Double(right)
}

/** / */
func /(left:CanCalProtocol, right:CanCalProtocol) -> Double{
    return CanCalProtocol2Double(left) / CanCalProtocol2Double(right)
}


/** CanCalProtocol高精度 */
func CanCalProtocol2Double(num: CanCalProtocol) -> Double{
    
    if num is Int {return Double(num as! Int)}
    if num is NSInteger {return Double(num as! NSInteger)}
    if num is Float {return Double(num as! Float)}
    if num is CGFloat {return Double(num as! CGFloat)}
    if num is Double {return num as! Double}
    
    return 0
}
