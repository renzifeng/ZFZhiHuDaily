//
//  ZFFooterView.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/2/18.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFFooterView: UIView {

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
        
        titleLabel = UILabel(frame: CGRectMake(ScreenWidth/2-20, 30, 120, 30))
        titleLabel.text = "载入下一篇"
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textColor = UIColor.lightGrayColor()
        titleLabel.textAlignment = .Left
        self.addSubview(titleLabel)
        
        arrowImageView = UIImageView(image: UIImage(named: "ZHAnswerViewPrevIcon"))
        arrowImageView.frame = CGRectMake(titleLabel.x-20, 35, 15, 20)
        self.addSubview(arrowImageView)
        
    }
    //没有下一篇（已经是最后一篇了）
    func notiNoMoreData() {
        titleLabel.x = ScreenWidth/2-55
        titleLabel.text = "已经是最后一篇了"
        arrowImageView.hidden = true
    }
    
    func hasMoreData() {
        titleLabel.x = ScreenWidth/2-20
        titleLabel.text = "载入下一篇"
        arrowImageView.hidden = false
    }

}
