//
//  ZFHeaderView.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/2/17.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFHeaderView: UIView {
    /// 箭头
    var arrowImageView : UIImageView!
    var titleLabel : UILabel!
    var maskImage : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBaseLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBaseLayout()
    }
    
    func initBaseLayout() {
        maskImage = UIImageView(image: UIImage(named: "News_Image_Mask"))
        maskImage.frame = CGRectMake(0, 0, ScreenWidth, 100)
        self.addSubview(maskImage)
        
        titleLabel = UILabel(frame: CGRectMake(ScreenWidth/2-20, 30, 110, 30))
        titleLabel.text = "载入上一篇"
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Left
        self.addSubview(titleLabel)

        arrowImageView = UIImageView(image: UIImage(named: "ZHAnswerViewBack"))
        arrowImageView.frame = CGRectMake(titleLabel.x-20, 35, 15, 20)
        self.addSubview(arrowImageView)
        
    }
    
    //没有上一篇（已经是第一篇了）
    func notiNoHeaderData() {
        titleLabel.x = ScreenWidth/2-55
        titleLabel.text = "已经是第一篇了"
        arrowImageView.hidden = true
    }
    
    func hasHeaderData() {
        titleLabel.x = ScreenWidth/2-20
        titleLabel.text = "载入上一篇"
        arrowImageView.hidden = false
    }
    // 配置图片颜色，文字颜色（header有图和无图颜色不一样）
    func configTintColor(hasPic : Bool) {
        if hasPic {
            titleLabel.textColor = UIColor.whiteColor()
            arrowImageView.image = UIImage(named:  "ZHAnswerViewBack")
            maskImage.hidden = false
        }else {
            titleLabel.textColor = UIColor.lightGrayColor()
            arrowImageView.image = UIImage(named:  "ZHAnswerViewBackIcon")
            maskImage.hidden = true
        }
    }
}
