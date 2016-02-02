//
//  ZFThemeViewModel.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/7.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZFThemeViewModel: NSObject {
    var themes : [ZFTheme] = []

    // 回调
    typealias ThemeViewModelSuccessCallBack = (dataSoure : Array<ZFTheme>) -> Void
    typealias ThemeVieModelErrorCallBack = (error : NSError) -> Void
    var successCallBack : ThemeViewModelSuccessCallBack?
    var errorCallBack : ThemeVieModelErrorCallBack?

    func getData (successCallBack : ThemeViewModelSuccessCallBack?, errorCallBack : ThemeVieModelErrorCallBack?) {
        self.successCallBack = successCallBack
        self.errorCallBack = errorCallBack
        ZFNetworkTool.get(THEME_URL, params: nil, success: { (json) -> Void in
            
            var others : [ZFTheme]?
            others = []
            if let items = JSON(json)["others"].array {
                for item in items {
                    others?.append(ZFTheme(json: item))
                }
                // 回调给controller
                if self.successCallBack != nil {
                    self.successCallBack!(dataSoure: others!)
                }
            } else {
                others = nil
            }

        }) { (error) -> Void in
                
        }
        
    }
}
