//
//  ZFThemeConfig.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/2/19.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

let CELL_COLOR = DKColorWithColors(UIColor.whiteColor(), RGB(39, 39, 39))
let CELL_TITLE = DKColorWithRGB(0x343434,0xffffff)

let TAB_HEADER = DKColorWithColors(ThemeColor, RGB(52, 52, 52))
func ThemeColorWithAlpha(alpha : CGFloat) -> DKColorPicker {
    return DKColorWithColors(RGBA(0, 130, 210, alpha),RGBA(52, 52, 52, alpha))
}

let TAB_SEPAROTOR = DKColorWithRGB(0xaaaaaa, 0x313131)