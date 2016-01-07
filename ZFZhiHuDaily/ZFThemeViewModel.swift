//
//  ZFThemeViewModel.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/7.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFThemeViewModel: NSObject {
    // 回调
    typealias XMHomeViewModelSuccessCallBack = (dataSoure : Array<ZFTheme>) -> Void
    typealias XMHomeVieModelErrorCallBack = (error : NSError) -> Void
    override init() {
        super.init()
    }
    func getData (successCallBack : XMHomeViewModelSuccessCallBack?, errorCallBack : XMHomeVieModelErrorCallBack?) {
        ZFNetworkTool.get(THEME_URL, params: nil, success: { (json) -> Void in
            print("-----\(json)")
            }) { (error) -> Void in
                
        }
    }
}
