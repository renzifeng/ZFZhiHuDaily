//
//  ZFHomeCell.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/7.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFHomeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    var news : ZFNews! {
        willSet {
            self.news = newValue
        }
        didSet {
            self.titleLabel.text  = news.title
            self.rightImageView.yy_setImageWithURL(NSURL(string: news.images![0]), placeholder: UIImage(named: "avatar"))
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
