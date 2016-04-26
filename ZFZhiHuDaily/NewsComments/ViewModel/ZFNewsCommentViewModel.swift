//
//  ZFNewsCommentViewModel.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/29.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZFNewsCommentViewModel {
    typealias CommentSuccessBlock = (commentsArray: [ZFComments]) -> Void
    
    func getLongComment(newsId: String, longComment : CommentSuccessBlock?) {
        ZFNetworkTool.get(NEWS_LONG_COMMENT(newsId), params: nil, success: { (json) -> Void in
            var comments: [ZFComments]?
            comments = []
            if let items = JSON(json)["comments"].array {
                for item in items {
                    comments?.append(ZFComments(json: item))
                }
                if longComment != nil {
                    longComment!(commentsArray: comments!)
                }
            } else {
                comments = nil
            }
        }) { (error) -> Void in
                
        }
    }
    
    func getShortComment(newsId: String, shortComment : CommentSuccessBlock?) {
        ZFNetworkTool.get(NEWS_LONG_COMMENT(newsId), params: nil, success: { (json) -> Void in
            var comments: [ZFComments]?
            comments = []
            if let items = JSON(json)["comments"].array {
                for item in items {
                    comments?.append(ZFComments(json: item))
                }
                if shortComment != nil {
                    shortComment!(commentsArray: comments!)
                }
            } else {
                comments = nil
            }
            }) { (error) -> Void in
                
        }
    }

    
    
    
    
}
