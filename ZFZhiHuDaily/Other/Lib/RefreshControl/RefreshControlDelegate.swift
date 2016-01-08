//
//  RefreshControlDelegate.swift
//  ZhiHuDaily-Swift
//
//  Created by SUN on 15/5/29.
//  Copyright (c) 2015年 SUN. All rights reserved.
//

import Foundation

/**
*  下拉响应事件的Delegate
*/
protocol RefreshControlDelegate {
    
    /**
    *  响应回调事件
    *  @param refreshControl 响应的控件
    *  @param direction 事件类型
    */
    func refreshControl(refreshControl:RefreshControl,didEngageRefreshDirection direction:RefreshDirection)
    
}