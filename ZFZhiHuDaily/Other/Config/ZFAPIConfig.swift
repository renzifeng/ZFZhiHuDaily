//
//  ZFAPIConfig.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/6.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import Foundation
// 网络超时时间
let NETWORK_TIMEOUT: NSTimeInterval = 15

let BASE_URL : String = "http://news-at.zhihu.com/api/"

// MARK: - 启动界面图像获取 start-image后为图像分辨率，接受如下格式
private let width : String = String(format: "%.0f", ScreenWidth)
private let height : String = String(format: "%.0f", ScreenHeight)
let START_IMAGE : String = "4/start-image/\(width)*\(height)"

// MARK: - 软件版本查询
let VERSION : String = String(format: "4/version/ios/%@", "1")
// MARK: - 最新消息
let LATEST_MSG : String =  "4/news/latest"