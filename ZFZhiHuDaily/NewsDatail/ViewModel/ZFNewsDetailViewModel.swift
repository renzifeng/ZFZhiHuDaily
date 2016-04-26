//
//  ZFNewsDetailViewModel.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/12.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import SwiftyJSON
import AwesomeCache

class ZFNewsDetailViewModel {
    /// 存放内容id的数组
    var newsIdArray : [String]!
    /// 是否有下一条
    var hasNext : Bool = false
    /// 是否有上一条
    var hasPrevious : Bool = false
    /// 要加载的下一条新闻id
    var nextId : String!
    /// 要加载的上一条新闻id
    var previousId : String!
    
    typealias SuccessCallBack = (newsDetail: ZFNewsDetail) -> Void
    typealias SuccessCallBackExtra = (newsExtra: ZFNewsExtra) -> Void
    let newsDetailCache = try! Cache<ZFNewsDetail>(name: "ZFNewsDetail")
    let newsExtraCache = try! Cache<ZFNewsExtra>(name: "ZFNewsExtra")
    
    func loadNewsDetail(id: String,complate: SuccessCallBack?, block: ErrorBlockCallBack?) {

        let index = self.newsIdArray.indexOf(id)!
        if index == 0 {
            hasPrevious = false
            hasNext = true
            previousId = self.newsIdArray[0]
            nextId = self.newsIdArray[index+1]
        }else if index > 0 && index < self.newsIdArray.count - 1 {
            hasPrevious = true
            hasNext = true
            previousId = self.newsIdArray[index-1]
            nextId = self.newsIdArray[index+1]
        }else {
            hasPrevious = true
            hasNext = false
            previousId = self.newsIdArray[index-1]
            nextId = self.newsIdArray[index]
        }
        //判断本地有没有缓存
        if let newsDatail = newsDetailCache[id] {
            if complate != nil {
                complate!(newsDetail: newsDatail)
            }
        }else {
            ZFNetworkTool.get(NEWS_DETAIL + id, params: nil, success: { (json) -> Void in
                let detail = ZFNewsDetail(object: json)
                //存储
                self.newsDetailCache[id] = detail
                
                if complate != nil {
                    complate!(newsDetail: detail)
                }
                
                }) { (error) -> Void in
                    
            }
        }
        
    }
    
    func loadNewsExra(id : String, complate: SuccessCallBackExtra?, error: ErrorBlockCallBack?) {
        //判断本地有没有缓存（先加载缓存，后请求数据）
        if let newsExtra = newsExtraCache[id] {
            if complate != nil {
                complate!(newsExtra: newsExtra)
            }
        }
        
        ZFNetworkTool.get(NEWS_EXTRA + id, params: nil, success: { (json) -> Void in
            let extra = ZFNewsExtra(object: json)
            //存储（更新数据）
            self.newsExtraCache[id] = extra
            
            complate!(newsExtra: extra)
            }) { (error) -> Void in
                
        }
    }
    

}
