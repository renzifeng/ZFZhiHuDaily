//
//  UITableViewCell+Exten.swift
//  WelCome
//
//  Created by 冯成林 on 15/8/25.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit


class CFCell: UITableViewCell {
    
    var model: AnyObject! {didSet{dataFill()}}
}

extension CFCell{
    
    static var rid: String {return stringFromClass(self)!}
    
    /** 获取cell */
    class func reuseCell(tableview: UITableView) -> CFCell{
        
        var cell = tableview.dequeueReusableCellWithIdentifier(rid) as? CFCell
        
        if cell == nil {cell = self.viewInitWithNib() as? CFCell}
        
        return cell!
    }
    
    
    /** 数据填充 */
    func dataFill(){}
    
}





