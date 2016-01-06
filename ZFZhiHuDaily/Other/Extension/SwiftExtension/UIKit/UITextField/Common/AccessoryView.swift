//
//  S.swift
//  TextFieldWithInputView
//
//  Created by 成林 on 15/8/24.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class AccessoryView: UIView {
    
    @IBOutlet weak var msgLabel: UILabel!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    var hideCancelBtn: Bool = false {didSet{hideCancelBtnAction()}}

    var doneBtnActionClosure,cancelBtnActionClosure: (Void->Void)!
    
    @IBOutlet weak var cancelBtnWC: NSLayoutConstraint!
    
}


extension AccessoryView{
    
    @IBAction func doneBtnAction(sender: UIButton) {doneBtnActionClosure?()}
    @IBAction func cancelBtnAction(sender: UIButton) {cancelBtnActionClosure?()}
    
    static func instance()->AccessoryView{return NSBundle.mainBundle().loadNibNamed("AccessoryView", owner: nil, options: nil).first as! AccessoryView}
    
    
    func hideCancelBtnAction(){
        if !hideCancelBtn {return}
        cancelBtnWC.constant=0
    }
}
