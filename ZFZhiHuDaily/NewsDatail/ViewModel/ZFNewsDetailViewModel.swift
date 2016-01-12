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
    
    func loadNewsDetail(id:String,complate:(newsDetail:ZFNewsDetail)->Void, block:((error:NSError) -> Void)? = nil) {
        ZFNetworkTool.get(NEWS_DETAIL + id, params: nil, success: { (json) -> Void in
            print("=========\(json)")
            let result = JSON(json)
            let newsDetailVO = self.convertJSON2VO(result)
            complate(newsDetail : newsDetailVO)
            
            }) { (error) -> Void in
                
        }
    }
    /**
     把JSON转换成为VO 对象
     
     - parameter json: json
     
     - returns: VO对象
     */
    private func convertJSON2VO(json:JSON) -> ZFNewsDetail {
        let id = json["id"].intValue
        
        let body = json["body"].stringValue
        
        let image_source = json["image_source"].stringValue
        
        let title = json["title"].stringValue
        
        let image = json["image"].stringValue
        
        let share_url = json["share_url"].stringValue
        
        let js = json["js"].array
        
        let recommenders = json["recommenders"].array
        
        let section = json["section"]
        
        let type = json["type"].int!
        
        let css = json["css"].array
        
        var jss:[String]=[]
        if let _js = js {
            for s in _js {
                jss.append(s.string!)
            }
        }
        
        var csss:[String]=[]
        if let _css = css {
            for s in _css {
                csss.append(s.string!)
            }
        }
        
        var recomms:[String]=[]
        if let _recommenders = recommenders {
            for r in _recommenders {
                recomms.append(r["avatar"].string!)
            }
        }
        
        var _section:Section? = nil
        if  section.error == nil {
            let thumbnail = section["thumbnail"].string!
            let i = section["id"].int!
            let sectionName = section["name"].string!
            _section = Section(thumbnail: thumbnail, id: i, name: sectionName)
        }
        
         let newsDetail = ZFNewsDetail(id: id, title: title, body: body, image: image, imageSource: image_source, type: type, css: csss, section: _section, recommenders: recomms, js: jss, shareUrl: share_url)
        
        return newsDetail
    }

}
