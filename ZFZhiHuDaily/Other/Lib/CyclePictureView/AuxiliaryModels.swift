//
//  AuxiliaryModels.swift
//  CyclePictureView
//
//  Created by wl on 15/11/8.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

//========================================================
// MARK: - 图片类型处理
//========================================================
enum ImageSource {
    case Local(name: String)
    case Network(urlStr: String)
}

enum ImageType {
    case Local
    case Network
}

struct ImageBox {
    var imageType: ImageType
    var imageArray: [ImageSource]
    
    init(imageType: ImageType, imageArray: [String]) {
        
        self.imageType = imageType
        self.imageArray = []
        
        switch imageType {
        case .Local:
            for str in imageArray {
                self.imageArray.append(ImageSource.Local(name: str))
            }
        case .Network:
            for str in imageArray {
                self.imageArray.append(ImageSource.Network(urlStr: str))
            }
        }
    }
    
    subscript (index: Int) -> ImageSource {
        get {
            return self.imageArray[index]
        }
    }
}

//========================================================
// MARK: - PageControl对齐协议
//========================================================

enum PageControlAliment {
    case CenterBottom
    case LeftBottom
    case RightBottom
}

protocol PageControlAlimentProtocol: class{
    var pageControlAliment: PageControlAliment {get set}
    func AdjustPageControlPlace(pageControl: UIPageControl)
}

extension PageControlAlimentProtocol where Self : UIView {
    func AdjustPageControlPlace(pageControl: UIPageControl) {

        if !pageControl.hidden {
            switch self.pageControlAliment {
            case .CenterBottom:
                let pageW:CGFloat = CGFloat(pageControl.numberOfPages * 15)
                let pageH:CGFloat = 20
                let pageX = self.center.x - 0.5 * pageW
                let pageY = self.bounds.height -  pageH
                pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH)
            case .LeftBottom:
                let pageW:CGFloat = CGFloat(pageControl.numberOfPages * 15)
                let pageH:CGFloat = 20
                let pageX = self.bounds.origin.x
                let pageY = self.bounds.height -  pageH
                pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH)
            case .RightBottom:
                let pageW:CGFloat = CGFloat(pageControl.numberOfPages * 15)
                let pageH:CGFloat = 20
                let pageX = self.bounds.width - pageW
                let pageY = self.bounds.height -  pageH
                pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH)

            }
        }
    }
}

//========================================================
// MARK: - 无限滚动协议
//========================================================
protocol EndlessCycleProtocol: class{
    /// 是否开启自动滚动
    var autoScroll: Bool {get set}
    /// 开启自动滚动后，自动翻页的时间
    var timeInterval: Double {get set}
    /// 用于控制自动滚动的定时器
    var timer: NSTimer? {get set}
    /// 是否开启无限滚动模式
    var needEndlessScroll: Bool {get set}
    /// 开启无限滚动模式后，cell需要增加的倍数
    var imageTimes: Int {get}
    /// 开启无限滚动模式后,真实的cell数量
    var actualItemCount: Int {get set}
    
    /**
    设置定时器,用于控制自动翻页
    */
    func setupTimer(userInfo: AnyObject?)

    /**
    在无限滚动模式中，显示的第一页其实是最中间的那一个cell
    */
    func showFirstImagePageInCollectionView(collectionView: UICollectionView)
}

extension EndlessCycleProtocol where Self : UIView  {
    
    func autoChangePicture(collectionView: UICollectionView) {
        
        guard actualItemCount != 0 else {
            return
        }
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let currentIndex = Int(collectionView.contentOffset.x / flowLayout.itemSize.width)
        
        let nextIndex = currentIndex + 1
        if nextIndex >= actualItemCount {
            showFirstImagePageInCollectionView(collectionView)
        }else {
            
            collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: nextIndex, inSection: 0), atScrollPosition: .None, animated: true)
        }
        
    }
    
    func showFirstImagePageInCollectionView(collectionView: UICollectionView) {
        guard actualItemCount != 0 else {
            return
        }
        var newIndex = 0
        if needEndlessScroll {
            newIndex = actualItemCount / 2
        }
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: newIndex, inSection: 0), atScrollPosition: .None, animated: false)
    }
}
