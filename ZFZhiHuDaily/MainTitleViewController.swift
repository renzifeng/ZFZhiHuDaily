//
//  MainTitleViewController.swift
//  ZhiHuDaily-Swift
//
//  Created by SUN on 15/5/29.
//  Copyright (c) 2015年 SUN. All rights reserved.
//

import UIKit

/**
*  主页面上部Title的View
*/
class MainTitleViewController: UIViewController,RefreshViewDelegate {

    private let BACKGROUND_COLOR_1 = UIColor(red: 0.098, green: 0.565, blue: 0.827, alpha: 1)
    private let BACKGROUND_COLOR_0 = UIColor(red: 0.098, green: 0.565, blue: 0.827, alpha: 0)
    
    private var _refreshControl:RefreshControl?     //关联的刷新Control
    
    //主页面上部Title上得 按键的事件委托
    var mainTitleViewDelegate:MainTitleViewDelegate?
    
    //View上的 各种组件
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!    
    @IBOutlet weak var circularProgress: KYCircularProgress!
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化圆形进度条
        circularProgress.lineWidth = 2.0
        circularProgress.progressAlpha = 0.85
        circularProgress.colors = [0xFFFFFF,0xFFFFFF]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    左边的按钮的事件响应
    
    - parameter sender:
    */
    @IBAction func leftButtonAction(sender: UIButton) {
        
        if let main = mainTitleViewDelegate {
            main.doLeftAction()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //===================以下是RefreshViewDelegate协议的实现===============================
    
    var refreshControl:RefreshControl? {
        get{
            return _refreshControl
        }
        
        set{
            _refreshControl = newValue
        }
    }
    
    /**
    重新设置Layout
    */
    func resetLayoutSubViews(){
        
    }
    
    /**
    松开可刷新的动画
    */
    func canEngageRefresh(scrollView:UIScrollView,direction:RefreshDirection){
        
    }
    
    func needContentInset(direction:RefreshDirection) -> Bool {
        return false
    }
    
    /**
    松开返回的动画
    */
    func didDisengageRefresh(scrollView:UIScrollView,direction:RefreshDirection){
        if  scrollView is UITableView {
            
            //只有是在上下滑动TableView的时候进行处理
            changeTitleViewAlpha(Float(scrollView.contentOffset.y))
            
            //只有是在下滑动TableView的时候进行处理
            changeTitleAndTableHeader(Float(scrollView.contentOffset.y), scrollView: scrollView)
            
            //用来显示重新加载的进度条
            showRefeshProgress(Float(scrollView.contentOffset.y))
            
        }
    }
    
    /**
    这部分是用来处理表格的第二个section和试图的titleView 之间的动画效果的
    
    - parameter offsetY:
    - parameter scrollView: 
    */
    func changeTitleAndTableHeader(offsetY:Float,scrollView:UIScrollView) {
        
        let needY=IN_WINDOW_HEIGHT-SCROLL_HEIGHT-TITLE_HEIGHT
        
        //计算出透明度
        let result =  offsetY/needY
        
        if  result > 1 {
            //只有当上划的距离已经大于needY了后,才开始做进一步的处理
            //设置最顶上得HeaderView的背景色
            topHeaderView.backgroundColor = BACKGROUND_COLOR_1
            
            //获取tableView
            let tableView = scrollView as! UITableView
            
            //获取第一个section有多少行数据
            let cellNumber = tableView.numberOfRowsInSection(0)
            
            //用于隐藏titleView的伐值, 算法是: (表格第一个section的行数-1)*每一个cell的高度+一个section的高度+上面的needY
            let hiddenHeight = Float(cellNumber-1) * TABLE_CELL_HEIGHT + SECTION_HEIGHT + needY
            
            //当当前拖动的距离大于了hiddenHeight, 就说明进入了第二个section了.那么就要把titleView隐藏了
            if Float(scrollView.contentOffset.y)>hiddenHeight{
                titleLabel.alpha = 0    //把今日热闻几个字隐藏了
                self.view.backgroundColor = BACKGROUND_COLOR_0      //隐藏titleView的背景色
            }else {
                //表示拖动距离小于第二个section了,进入了第一个section了.那么就要显示东西了
                titleLabel.alpha = 1
            }
            
            //设置表格的滑动的contentInset 为top偏移100. 这样 第二个,第三个section的标题就会自动的在 屏幕头上悬浮
            scrollView.contentInset = UIEdgeInsetsMake(CGFloat(100), 0, 0, 0)
        }else {
            //表明已经进入了图片轮播区了,恢复初始值
            topHeaderView.backgroundColor = UIColor.clearColor()
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        
    }
    
    //这部分是用来根据TableView的滑动来调整TitleView的透明度的
    func changeTitleViewAlpha(offsetY:Float){
        //计算出最大上划大小. 当上划到此处后, title就全部显示
        let needY=IN_WINDOW_HEIGHT-SCROLL_HEIGHT-TITLE_HEIGHT
        
        //计算出透明度
        var result =  offsetY/needY
        
        result = max(min(result,1.0),0.0)
        
        
        //这里使用的是修改他得背景颜色的透明度来实现的.不直接使用titleView.alpha = CGFloat(result)是因为, 这样修改会导致这个View上面的所有的subView都会透明
        self.view.backgroundColor = UIColor(red: 0.098, green: 0.565, blue: 0.827, alpha: CGFloat(result))
    }
    
    /**
    显示刷新的进度条
    
    - parameter offsetY:
    */
    func showRefeshProgress(offsetY:Float){
        
        //计算出透明度
        var result=(0-offsetY)/SCROLL_HEIGHT
        
        result = max(min(result,1.0),0.0)
        
        
        circularProgress.progress = Double(result)
    }

    
    /**
    开始刷新的动画
    */
    func startRefreshing(direction:RefreshDirection){
        
        //判断出是从上到下的刷新
        if  direction == RefreshDirection.RefreshDirectionTop {
            circularProgress.alpha = 0
            activityIndicator.startAnimating()
            activityIndicator.alpha = 1
        }
        
    }
    
    /**
    结束刷新的动画
    */
    func finishRefreshing(direction:RefreshDirection){
        
        //判断出是从上到下的刷新
        if direction == RefreshDirection.RefreshDirectionTop {
            self.activityIndicator.stopAnimating()
            //这个地方需要调用progress两次,因为他源码里面progress的didset决定的
            circularProgress.progress = 0
            circularProgress.progress = 0
            self.circularProgress.alpha = 1
            self.activityIndicator.alpha = 0
        }
        
    }
}

/**
*  自定义的协议,主要用来响应Title上左边的按钮的事件委托
*/
protocol MainTitleViewDelegate {
    /**
    *  委托左边按钮的事件
    */
    func doLeftAction()
}
