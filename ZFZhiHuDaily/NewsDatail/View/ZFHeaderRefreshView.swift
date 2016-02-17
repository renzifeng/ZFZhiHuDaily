//
//  ZFHeaderRefreshView.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/2/17.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFHeaderRefreshView: UIView {
    /// 箭头
    var arrowImageView : UIImageView!
    var titleLabel : UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBaseLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBaseLayout()
    }
    
    func initBaseLayout() {
        let maskImage = UIImageView(image: UIImage(named: "News_Image_Mask"))
        maskImage.frame = CGRectMake(0, 0, ScreenWidth, 60)
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
    
    func hasheaderData() {
        titleLabel.x = ScreenWidth/2-20
        titleLabel.text = "载入上一篇"
        arrowImageView.hidden = false
    }
}
