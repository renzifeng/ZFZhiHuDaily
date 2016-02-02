//
//  CyclePictureCell.swift
//  CyclePictureView
//
//  Created by wl on 15/11/7.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit
import Kingfisher

class CyclePictureCell: UICollectionViewCell {

    var imageSource: ImageSource = ImageSource.Local(name: ""){
        didSet {
            switch imageSource {
            case let .Local(name):
                self.imageView.image = UIImage(named: name)
            case let .Network(urlStr):
                self.imageView.kf_setImageWithURL(NSURL(string: urlStr)!, placeholderImage: placeholderImage)
            }
        }
    }
    
    var placeholderImage: UIImage?
    
    var imageDetail: String? {
        didSet {
            detailLable.hidden = false
            detailLable.text = imageDetail

        }
    }
    
    var detailLableTextFont: UIFont = UIFont(name: "Helvetica-Bold", size: 18)! {
        didSet {
            detailLable.font = detailLableTextFont
        }
    }
    
    var detailLableTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            detailLable.textColor = detailLableTextColor
        }
    }
    
    var detailLableBackgroundColor: UIColor = UIColor.clearColor() {
        didSet {
            detailLable.backgroundColor = detailLableBackgroundColor
        }
    }
    
    var detailLableHeight: CGFloat = 60 {
        didSet {
            detailLable.frame.size.height = detailLableHeight
        }
    }
    
    var detailLableAlpha: CGFloat = 1 {
        didSet {
            detailLable.alpha = detailLableAlpha
        }
    }
    
    var pictureContentMode: UIViewContentMode = .ScaleAspectFill {
        didSet {
            imageView.contentMode = pictureContentMode
        }
    }
    
    private var imageView: UIImageView!
    private var detailLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupImageView()
        self.setupDetailLable()
//        self.backgroundColor = UIColor.grayColor()
    }
    
    private func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = pictureContentMode
        imageView.clipsToBounds = true
        self.addSubview(imageView)
    }
    
    private func setupDetailLable() {
        detailLable = UILabel()
        detailLable.textColor = detailLableTextColor
        detailLable.shadowColor = UIColor.grayColor()
        detailLable.numberOfLines = 0
        detailLable.backgroundColor = detailLableBackgroundColor

        detailLable.hidden = true //默认是没有描述的，所以隐藏它
        
        self.addSubview(detailLable!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = self.bounds

        if let _ = self.imageDetail {
            let lableX: CGFloat = 20
            let lableH: CGFloat = detailLableHeight
            let lableW: CGFloat = self.frame.width - lableX
            let lableY: CGFloat = self.frame.height - lableH
            detailLable.frame = CGRectMake(lableX, lableY, lableW, lableH)
            detailLable.font = detailLableTextFont
        }
    }
}
