//
//  CyclePictureView.swift
//  CyclePictureView
//
//  Created by wl on 15/11/7.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

protocol CyclePictureViewDelegate: class{
    func cyclePictureView(cyclePictureView: CyclePictureView, didSelectItemAtIndexPath indexPath: NSIndexPath)
}

class CyclePictureView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, PageControlAlimentProtocol, EndlessCycleProtocol {

// MARK: - 属性接口
//========================================================
// MARK: 数据源
//========================================================
    
    /// 存放本地图片名称的数组
    var localImageArray: [String]? {
        didSet {
            self.imageBox = ImageBox(imageType: .Local, imageArray: localImageArray!)
            self.reloadData()
        }

    }
    /// 存放网络图片路径的数组
    var imageURLArray: [String]? {
        didSet {
            self.imageBox = ImageBox(imageType: .Network, imageArray: imageURLArray!)
            self.reloadData()
        }
    }
    /// 图片的描述文字
    var imageDetailArray: [String]?
    
//========================================================
// MARK:  自定义样式接口
//========================================================
    var showPageControl: Bool = true {
        didSet {
            self.pageControl?.hidden = !showPageControl
        }
    }
    var currentDotColor: UIColor = UIColor.orangeColor() {
        didSet {
            self.pageControl?.currentPageIndicatorTintColor = currentDotColor
        }
    }
    var otherDotColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            self.pageControl?.pageIndicatorTintColor = otherDotColor
        }
    }
    /// pageControl的位置，默认是剧中在底部(PageControlAlimentProtocol提供)
    var pageControlAliment: PageControlAliment = .CenterBottom
    /// 加载网络图片使用的占位图片
    var placeholderImage: UIImage?
    /// 图片的对齐模式
    var pictureContentMode: UIViewContentMode?
    
    // 一些cell文字描述的属性
    var detailLableTextFont: UIFont?
    var detailLableTextColor: UIColor?
    var detailLableBackgroundColor: UIColor?
    var detailLableHeight: CGFloat?
    var detailLableAlpha: CGFloat?
    
//========================================================
// MARK: 滚动控制接口
//========================================================
    
    weak var delegate: CyclePictureViewDelegate?
    /// 是否开启自动滚动,默认是ture,EndlessCycleProtocol提供
    var autoScroll: Bool = true {
        didSet {
            self.timer?.invalidate() //先取消先前定时器
            if autoScroll {
                self.setupTimer(nil)   //重新设置定时器
            }
        }
    }
    /// 开启自动滚动后，自动翻页的时间，默认为3秒,EndlessCycleProtocol提供
    var timeInterval: Double = 3.0 {
        didSet {
            if autoScroll {
                self.setupTimer(nil)   //重新设置定时器
            }
        }
    }
    /// 是否开启无限滚动模式,EndlessCycleProtocol提供
    var needEndlessScroll: Bool  = true {
        didSet {
            self.reloadData()
        }
    }
    
//========================================================
// MARK: - 内部属性
//========================================================
    
    private var imageBox: ImageBox?
    /// 开启无限滚动模式后,真实的cell数量
    var actualItemCount: Int = 0 // EndlessCycleProtocol提供
    let imageTimes: Int = 150   // EndlessCycleProtocol提供
    /// 控制自动滚动的定时器
    var timer: NSTimer?     // EndlessCycleProtocol提供
    
    private var pageControl: UIPageControl?
    private var collectionView: UICollectionView!
    private let cellID: String = "CyclePictureCell"
    private var flowLayout: UICollectionViewFlowLayout?

     // MARK: - 初始化方法
    
    init(frame: CGRect, localImageArray: [String]?) {
        
        super.init(frame: frame)
        self.setupCollectionView()
        
        if let array = localImageArray {
            self.localImageArray = array
            self.imageBox = ImageBox(imageType: .Local, imageArray: localImageArray!)
            self.reloadData()
        }
    }
    
    init(frame: CGRect, imageURLArray: [String]?) {
        
        super.init(frame: frame)
        self.setupCollectionView()
        
        if let array = imageURLArray {
            self.imageURLArray = array
            self.imageBox = ImageBox(imageType: .Local, imageArray: imageURLArray!)
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupCollectionView()
    }
    
    deinit{
        //print("CyclePictureView---deinit")
    }
    
    func layoutFirstPage() {
        self.showFirstImagePageInCollectionView(self.collectionView)
    }
    
    /**
    设置CollectionView相关内容
    */
    private func setupCollectionView() {
        
        // 初始化布局
        let flowLayout =  UICollectionViewFlowLayout()

//        flowLayout.itemSize = self.frame.size
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        self.flowLayout = flowLayout
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
//        collectionView.backgroundColor = UIColor.orangeColor()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.pagingEnabled = true
        collectionView.scrollsToTop = false
        // TODO: view充当数据源和代理，感觉不符合逻辑，待修改
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(CyclePictureCell.self, forCellWithReuseIdentifier: cellID)
        self.addSubview(collectionView)

        self.collectionView = collectionView
    }
    /**
    设置PageControl
    */
    private func setupPageControl() {
        
        self.pageControl?.removeFromSuperview()
        
        guard self.imageBox!.imageArray.count > 1 else {
            return
        }
        
        if self.showPageControl {
            let pageControl = UIPageControl()
            pageControl.numberOfPages = self.imageBox!.imageArray.count
            pageControl.currentPageIndicatorTintColor = self.currentDotColor
            //pageControl.pageIndicatorTintColor = self.otherDotColor
            pageControl.userInteractionEnabled = false
            self.addSubview(pageControl)
            
            self.pageControl = pageControl
        }

    }
    
// MARK: - 内部方法
    
    /**
    解决定时器强引用视图，导致视图不被释放
    */
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        guard let _ = newSuperview else {
            self.timer?.invalidate()
            self.timer = nil
            return
        }
    }
    /**
    重新加载数据，每当localImageArray或者imageURLArray
    被设置的时候调用
    */
    private func reloadData() {
        
        guard let imageBox = self.imageBox else {
            //print("reloadData---error")
            return
        }
        
        if imageBox.imageArray.count > 1 {
            self.actualItemCount =  self.needEndlessScroll ? imageBox.imageArray.count * imageTimes : imageBox.imageArray.count
        }else {
            self.actualItemCount = 1
        }
        
        //重新加载数据
        self.collectionView.reloadData()
        self.setupPageControl()
        if self.autoScroll {
            self.setupTimer(nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        self.flowLayout?.itemSize = self.frame.size
        self.collectionView.frame = self.bounds
        //解决从SB中加载时，contentInset.Top默认为64的问题
        self.collectionView.contentInset = UIEdgeInsetsZero
        //下拉后恢复显示第一个
        //self.showFirstImagePageInCollectionView(self.collectionView)
        
        guard let pageControl = self.pageControl else {
            return
        }
        //PageControlAlimentProtocol协议方法，用于调整对齐
        self.AdjustPageControlPlace(pageControl)
    }
    /**
    设置定时器,EndlessCycleProtocol提供
    */
    func setupTimer(userInfo: AnyObject?) {
        self.timer?.invalidate() //先取消先前定时器
        let timer = NSTimer(timeInterval: timeInterval, target: self, selector: #selector(CyclePictureView.changePicture), userInfo: userInfo, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        self.timer = timer
    }
    /**
    定时器回调方法，用于自动翻页
    */
    func changePicture() {
        // 继续调用协议默认实现
        self.autoChangePicture(self.collectionView)
    }
    
}


// MARK: - scrollView 代理
extension CyclePictureView {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if self.autoScroll {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.autoScroll {
            self.setupTimer(nil)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard let pageControl = self.pageControl else {
            return
        }
        let currentIndex = Int(self.collectionView.contentOffset.x / self.flowLayout!.itemSize.width)
        pageControl.currentPage = currentIndex % self.imageBox!.imageArray.count
    }

}

// MARK: - collectionView 数据源
extension CyclePictureView {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.actualItemCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! CyclePictureCell
        
        if let placeholderImage = self.placeholderImage {
            cell.placeholderImage = placeholderImage
        }
        
        if let pictureContentMode = self.pictureContentMode {
            cell.pictureContentMode = pictureContentMode
        }
        
        if let imageBox = self.imageBox {
            let actualItemIndex = indexPath.item % imageBox.imageArray.count
            cell.imageSource = imageBox[actualItemIndex]
        }
        
        if let array = self.imageDetailArray {
            let actualItemIndex = indexPath.item % array.count
            cell.imageDetail = array[actualItemIndex]
            // TODO: 好恶心的判决金字塔，不知道有什么办法解决
            if let font = self.detailLableTextFont {
                cell.detailLableTextFont = font
            }
            if let color = self.detailLableTextColor {
                cell.detailLableTextColor = color
            }
            if let backgroundColor = self.detailLableBackgroundColor {
                cell.detailLableBackgroundColor = backgroundColor
            }
            if let height = self.detailLableHeight {
                cell.detailLableHeight = height
            }
            if let aphla = self.detailLableAlpha {
                cell.detailLableAlpha = aphla
            }
            
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.cyclePictureView(self, didSelectItemAtIndexPath: NSIndexPath(forItem: indexPath.item % self.imageBox!.imageArray.count, inSection: indexPath.section))
    }
    
}
