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
            let result = JSON(json)
            //主题列表
            let themes:[JSON]? = result["others"].array
            
            for theme in themes! {
                self.themes.append(self.convertJSON2Theme(theme))
            }
            // 回调给controller
            if self.successCallBack != nil {
                self.successCallBack!(dataSoure: self.themes)
            }
        }) { (error) -> Void in
                
        }
        
    }
    /**
     JSON对象和VO对象的转换
     
     - parameter json:
     
     - returns:
     */
    private func convertJSON2Theme(json:JSON) -> ZFTheme {
        let color = json["color"].intValue
        let thumbnail = json["thumbnail"].stringValue
        let description = json["description"].stringValue
        let id = json["id"].intValue
        let name = json["name"].stringValue
        
        return ZFTheme(color: color, thumbnail: thumbnail, description: description, id: id, name: name)
    }
}
