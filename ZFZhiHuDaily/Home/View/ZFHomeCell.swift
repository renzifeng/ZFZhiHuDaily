//
//  ZFHomeCell.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/7.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import Kingfisher

class ZFHomeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreImageView: UIImageView!
    var news : ZFStories! {
        willSet {
            self.news = newValue
        }
        didSet {
            self.titleLabel.text  = news.title
            self.rightImageView.kf_setImageWithURL(NSURL(string: news.images![0])!, placeholderImage: UIImage(named: "Image_Preview"))
            if news.multipic {
                self.moreImageView.hidden = false
            }else {
                self.moreImageView.hidden = true
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.dk_backgroundColorPicker = CELL_COLOR
        self.titleLabel.dk_textColorPicker = CELL_TITLE
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
