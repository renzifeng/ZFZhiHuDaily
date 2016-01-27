//
//  ZFNewsDetailViewModel.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/12.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZFNewsDetailViewModel {
    
    typealias SuccessCallBack = (newsDetail: ZFNewsDetail) -> Void
    typealias SuccessCallBackExtra = (newsExtra: ZFNewsExtra) -> Void
    
    func loadNewsDetail(id: String,complate: SuccessCallBack?, block: ErrorBlockCallBack?) {
        ZFNetworkTool.get(NEWS_DETAIL + id, params: nil, success: { (json) -> Void in

            let detail = ZFNewsDetail(object: json)
            if complate != nil {
                complate!(newsDetail: detail)
            }
            
            }) { (error) -> Void in
                
        }
    }
    
    func loadNewsExra(id : String, complate: SuccessCallBackExtra?, error: ErrorBlockCallBack?) {
        ZFNetworkTool.get(NEWS_EXTRA + id, params: nil, success: { (json) -> Void in
            let extra = ZFNewsExtra(object: json)
            complate!(newsExtra: extra)
            }) { (error) -> Void in
                
        }
    }

}
