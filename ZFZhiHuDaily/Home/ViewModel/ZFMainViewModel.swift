//
//  ZFMainViewModel.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/7.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import SwiftyJSON

class ZFMainViewModel: NSObject {
    var themes : [ZFTheme] = []
    // 回调
    typealias ViewModelSuccessCallBack = (dataSoure : Array<ZFStories>,headerSource : Array<ZFTopStories>) -> Void
    typealias ListSuccessCallBack = (dataSoure : Array<ZFStories>,dateStr : String) -> Void
    typealias ThemeVieModelErrorCallBack = (error : NSError) -> Void
    /// 今日热闻、轮播图的回调
    var successCallBack : ViewModelSuccessCallBack?
    /// 列表的成功回调
    var listSuccessCallBack : ListSuccessCallBack?
    /// 失败回调
    var errorCallBack : ThemeVieModelErrorCallBack?
    /// dateFormat
    var dateFormat : NSDateFormatter = NSDateFormatter()
    
    /**
     获取今日热闻、轮播图数据
     
     - parameter successCallBack: successCallBack description
     - parameter errorCallBack:   errorCallBack description
     */
    func getData (successCallBack : ViewModelSuccessCallBack?, errorCallBack : ThemeVieModelErrorCallBack?) {
        self.successCallBack = successCallBack
        self.errorCallBack = errorCallBack
        ZFNetworkTool.get(LATEST_NEWS_URL, params: nil, success: { (json) -> Void in
            
            let allNews : ZFLatestNews = ZFLatestNews(object: json)
            let topStories = allNews.topStories
            let stories1 = allNews.stories
            
            print("\(topStories)====\(stories1)")

            // 回调给controller
            if self.successCallBack != nil {
                self.successCallBack!(dataSoure:stories1!, headerSource:topStories!)
            }
            }) { (error) -> Void in
                
        }
    }
    /**
     获取往日的新闻
     
     - parameter dateIndex:       页数的下标，相当于取出date，根据date查询当日数据
     - parameter successCallBack: successCallBack description
     - parameter errorCallBack:   errorCallBack description
     */
    func getDataForDate (dateIndex: Int ,successCallBack : ListSuccessCallBack?, errorCallBack : ThemeVieModelErrorCallBack?) {
        let date : NSDate = NSDate(timeIntervalSinceNow: -(dateIndex*24*60*60))
        dateFormat.locale = NSLocale(localeIdentifier: "zh_CN")
        dateFormat.dateFormat = "yyyyMMdd"
        let dateStr : String =  dateFormat.stringFromDate(date)
        
        self.listSuccessCallBack = successCallBack
        //若果需要查询 11 月 18 日的消息，before 后的数字应为 20131119
        ZFNetworkTool.get(BEFORE_NEWS + dateStr, params: nil, success: { (json) -> Void in
            
            let beforeNews = ZFBeforeNews(object: json)
            let stories = beforeNews.stories
            
            self.dateFormat.dateFormat = "MM月dd日 cccc"
            let dateStr = self.dateFormat.stringFromDate(date)
            
            // 回调给controller
            if self.listSuccessCallBack != nil {
                self.listSuccessCallBack!(dataSoure:stories!,dateStr:dateStr)
            }
            }) { (error) -> Void in
                
        }
        
    }

}
