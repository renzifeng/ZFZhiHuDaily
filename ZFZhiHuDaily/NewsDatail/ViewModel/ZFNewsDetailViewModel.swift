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
    
    typealias SuccessCallBack = (newsDetail:ZFNewsDetail) -> Void
    
    func loadNewsDetail(id: String,complate: SuccessCallBack?, block: ErrorBlockCallBack?) {
        ZFNetworkTool.get(NEWS_DETAIL + id, params: nil, success: { (json) -> Void in

            let detail = ZFNewsDetail(object: json)
            if complate != nil {
                complate!(newsDetail: detail)
            }
            
            }) { (error) -> Void in
                
        }
    }

}
