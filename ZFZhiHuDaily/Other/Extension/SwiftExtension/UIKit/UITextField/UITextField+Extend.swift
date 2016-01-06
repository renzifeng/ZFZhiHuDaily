//
//  UITextField+Extend.swift
//  WelCome
//
//  Created by 冯成林 on 15/7/22.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit



/** textField检查 */
extension UITextField{
    
    class TFCheckModel{
        
        let textField: UITextField
        let desc: String
        
        init(textField: UITextField, desc: String){
            
            self.textField = textField
            self.desc = desc
        }
        
    
    }
    

    /** 检查 */
    class func checkWithTFCheckModels(modelsClosure: () -> [TFCheckModel]) -> String {
        
        var errorMsg: String = ""
    
        //执行
        let models = modelsClosure()
    
        /** 数组遍历 */
        for (_, model): (Int, TFCheckModel) in models.enumerate(){
            if model.textField.text!.isEmpty {errorMsg = model.desc; break}
        }
        
        if errorMsg.isNotEmpty {errorMsg+="为空"}
        
        return errorMsg
    }
    
    /** 添加一个键盘 */
    func addKeyBoardTool(explain explain: String){
        
        let av = AccessoryView.instance()
        av.hideCancelBtn = true
        av.msgLabel.text = explain
        av.doneBtnActionClosure={self.endEditing(true)}
        self.inputAccessoryView = av
    }
    
    
    /** 手机号码格式化 */
    func formatMobileNO(string: String) -> Bool{
        
        let str =  self.text

        let length = str!.length
        
        if string.characters.elementsEqual("".characters) {
            
            if ((length - 2) % 5 == 0) {
                self.text = (str! as NSString).substringToIndex(length - 1)
            }
            
            return true;
            
        }else {
            
            if length==0{return true}
            
            if length >= 13 {return false}
            
            var count = 4
            var leftCount = -1
            
            if length > 5 {count=5; leftCount=count-2}
            
            if ((length - leftCount) % count == 0) {
                self.text = "\(str) "
            }
        }
        
        return true
    }
}

extension UISearchBar{
    /** 添加一个键盘 */
    func addKeyBoardTool(explain explain: String){
        
        let av = AccessoryView.instance()
        av.hideCancelBtn = true
        av.msgLabel.text = explain
        av.doneBtnActionClosure={self.endEditing(true)}
        self.inputAccessoryView = av
    }
}






