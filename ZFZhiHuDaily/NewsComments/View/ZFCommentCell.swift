//
//  ZFCommentCell.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/30.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import Kingfisher

class ZFCommentCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var zanBtn: ImageTextButton!
    var comment : ZFComments! {
        didSet {
            avatarImageView.kf_setImageWithURL(NSURL(string: comment.avatar!)!, placeholderImage: UIImage(named: "Editor_Profile_Avatar"))
            userNameLabel.text = comment.author!
            contentLabel.text = comment.content!
            zanBtn.setTitle(" \(comment.likes!)", forState: .Normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //切圆角
        cutRoundWith(avatarImageView)
        
        zanBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentLeft
        
        dk_backgroundColorPicker = CELL_COLOR
        userNameLabel.dk_textColorPicker = CELL_TITLE
        contentLabel.dk_textColorPicker = CELL_TITLE
        selectionStyle = .None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
