//
//  ZFLeftHeader.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/5.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFLeftHeader: UIView {

    @IBOutlet weak var collectBtn: ImageTextButton!
    @IBOutlet weak var msgBtn: ImageTextButton!
    @IBOutlet weak var settingBtn: ImageTextButton!
    class func leftHeader () -> ZFLeftHeader {
        return NSBundle.mainBundle().loadNibNamed("ZFLeftHeader", owner: nil, options: nil).first as! ZFLeftHeader
    }
    
    override func awakeFromNib() {
        collectBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentUp;
        msgBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentUp;
        settingBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentUp;
        collectBtn.imgTextDistance = 10;
        msgBtn.imgTextDistance = 20;
        settingBtn.imgTextDistance = 20;
        backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
    }

}
