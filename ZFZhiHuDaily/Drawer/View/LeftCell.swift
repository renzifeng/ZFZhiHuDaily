//
//  LeftCell.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/5.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class LeftCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var theme : ZFTheme! {
        willSet {
            self.theme = newValue
        }
        didSet {
            self.titleLabel.text  = theme.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.darkGrayColor()
        backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        let selectView = UIView()
        selectView.backgroundColor = UIColor.blackColor()
        selectedBackgroundView = selectView
        titleLabel.highlightedTextColor = UIColor.whiteColor()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
