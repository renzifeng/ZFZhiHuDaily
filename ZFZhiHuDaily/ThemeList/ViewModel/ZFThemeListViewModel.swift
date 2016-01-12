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
    var themes : [ZFThemeList] = []
    
    typealias SuccessCallBackBlock = (dataSources : ZFThemeList) -> Void

    var successBlock : SuccessCallBackBlock?
    var errorBlock : ErrorBlockCallBack?
    weak var tableView : UITableView!
    /// tableView数据源
    var dataSoure : [ThemeStories] = []
    /**
     获取主题日报
     
     - parameter themeId:      主题日报themeId
     - parameter successBlock: successBlock description
     - parameter errorBlock:   errorBlock description
     */
    func getListData (themeId : String , successBlock : SuccessCallBackBlock,errorBlock : ErrorBlockCallBack) {
        self.successBlock = successBlock
        self.errorBlock = errorBlock
        ZFNetworkTool.get(THEME_LIST + themeId, params: nil, success: { (json) -> Void in
            print("========\(json)")
            let data = JSON(json)
            // 回调给controller
            if (self.successBlock != nil) {
                successBlock(dataSources: self.convertJSON2ThemeList(data))
            }
//            let themeList = self.convertJSON2ThemeList(data)
//            self.dataSoure = themeList.stories!
//            self.tableView.reloadData()
            }) { (error) -> Void in
                
        }
    }
    
    private func convertJSON2ThemeList(json:JSON) -> ZFThemeList {
        let background = json["background"].stringValue
        let color = json["color"].intValue
        let description = json["description"].stringValue
        let image = json["image"].stringValue
        let image_source = json["image_source"].stringValue
        let name = json["name"].stringValue
        var storiesArray : [ThemeStories] = []
        if let stories = json["stories"].array {
            for story in stories {
                let id = story["id"].int!
                let title = story["title"].string!
                let type = story["type"].int!
                var imagesArray : [String] = []
                if let images = story["images"].array {
                    let img = images
                    for i in img {
                        imagesArray.append(i.string!)
                    }
                }else {
                    imagesArray = []
                }
                let oneStory : ThemeStories = ThemeStories(id: id, title: title, type: type, images: imagesArray)
                storiesArray.append(oneStory)
            }
        }
        
        var editorsArray : [ThemeEditors] = []
        if let editors = json["editors"].array {
            for editor in editors {
                let avatar = editor["avatar"].string!
                let bio = editor["bio"].string!
                let id = editor["id"].int!
                let name = editor["name"].string!
                let url = editor["url"].string!
                editorsArray.append(ThemeEditors(avatar: avatar, bio: bio, id: id, name: name, url: url))
            }
        }
        return ZFThemeList(background: background, color: color, description: description, image: image, image_source: image_source, name: name, editors: editorsArray, stories: storiesArray)
    }
    


}
