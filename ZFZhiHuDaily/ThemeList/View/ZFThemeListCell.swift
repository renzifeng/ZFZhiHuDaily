//
//  ZFThemeListCell.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/11.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import Kingfisher

class ZFThemeListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    var story : ZFThemeStories! {
        didSet {
            self.titleLabel.text = story.title
            if story.images != nil {
                self.rightImageView.kf_setImageWithURL(NSURL(string: story.images![0])!, placeholderImage: UIImage(named: "Image_Preview"))
                self.imageWidthConstraint.constant = 80;
            }else {
                self.imageWidthConstraint.constant = 0;
            }
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
