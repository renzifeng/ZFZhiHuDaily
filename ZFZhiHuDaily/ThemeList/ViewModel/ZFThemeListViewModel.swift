//
//  ZFThemeListViewModel.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/11.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZFThemeListViewModel: NSObject {
    
    typealias SuccessCallBackBlock = (dataSources : ZFThemeDetail) -> Void

    var successBlock : SuccessCallBackBlock?
    var errorBlock : ErrorBlockCallBack?
    weak var tableView : UITableView!
    /// tableView数据源
    var dataSoure : [ZFThemeStories] = []
    
    /**
     获取主题日报
     
     - parameter themeId:      主题日报themeId
     - parameter successBlock: successBlock description
     - parameter errorBlock:   errorBlock description
     */
    func getListData (themeId : String , successBlock : SuccessCallBackBlock,errorBlock : ErrorBlockCallBack) {

        ZFNetworkTool.get(THEME_LIST + themeId, params: nil, success: { (json) -> Void in
            let themeList = ZFThemeDetail(object: json)
            // 回调给controller
            successBlock(dataSources: themeList)

            }) { (error) -> Void in
        }
    }
    
}
