//
//  RefreshViewDelegate.swift
//  ZhiHuDaily-Swift
//
//  Created by SUN on 15/5/29.
//  Copyright (c) 2015年 SUN. All rights reserved.
//

import Foundation

protocol RefreshViewDelegate {
    
    var refreshControl:RefreshControl? {get set}
    
    /**
    重新设置Layout
    */
    func resetLayoutSubViews()
    
    /**
    松开可刷新的动画
    */
    func canEngageRefresh(scrollView:UIScrollView,direction:RefreshDirection)
    
    /**
    松开返回的动画
    */
    func didDisengageRefresh(scrollView:UIScrollView,direction:RefreshDirection)
    
    /**
    *  是否修改他的 ContentInset
    */
    func needContentInset(direction:RefreshDirection) -> Bool
    
    /**
    开始刷新的动画
    */
    func startRefreshing(direction:RefreshDirection)
    
    /**
    结束刷新的动画
    */
    func finishRefreshing(direction:RefreshDirection)
    
}
