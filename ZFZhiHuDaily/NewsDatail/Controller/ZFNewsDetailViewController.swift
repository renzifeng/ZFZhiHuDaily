//
//  ZFNewsDetailViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/12.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Kingfisher

class ZFNewsDetailViewController: ZFBaseViewController,UIWebViewDelegate,UIScrollViewDelegate {
    /// 容器view
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var zanBtn: ZanButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var commentNumLabel: UILabel!
    @IBOutlet weak var zanNumLabel: UILabel!
    @IBOutlet weak var nextNewsBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    /// 存放内容id的数组
    var newsIdArray : [String]!
    /// 新闻id
    var newsId : String!
    var viewModel = ZFNewsDetailViewModel()
    var backgroundImg : UIImageView!
    /// top图片上的title
    var titleLabel : UILabel!
    /// 新闻额外信息
    var newsExtra : ZFNewsExtra!
    /// loading
    var activityIndicatorView : NVActivityIndicatorView!
    /// 判断是否有图
    var hasPic : Bool = false
    /// 是否正在加载
    var isLoading : Bool = false
    /// headerView
    var headerView : ZFHeaderView!
    /// footerView
    var footerView : ZFFooterView!
    /// 是否为夜间模式
    var isNight : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mode = NSUserDefaults.standardUserDefaults().objectForKey("NightOrLightMode") as! String
        if mode == "light"{
            //白天模式
            isNight = false
        }else if mode == "night" {
            //夜间模式
            isNight = true
        }

        setupUI()
        //赞
        setupZan()
        
        viewModel.newsIdArray = self.newsIdArray
        getNewsWithId(self.newsId)
        bottomView.dk_backgroundColorPicker = BG_COLOR
        self.webView.dk_backgroundColorPicker = BG_COLOR
        self.view.dk_backgroundColorPicker = BG_COLOR
    }
    
    // MARK: - SetupUI
    
    func setupUI() {
        statusView.backgroundColor = UIColor.clearColor()
        navView.hidden = true
        
        backgroundImg = UIImageView()
        backgroundImg.contentMode = .ScaleAspectFill
        backgroundImg.clipsToBounds = true
        backgroundImg.frame = CGRectMake(0, -60, ScreenWidth, CGFloat(265))
        self.webView.scrollView.addSubview(backgroundImg)
        self.webView.scrollView.delegate = self
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.boldSystemFontOfSize(20.0)
        backgroundImg.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
        
        let x = self.view.center.x
        let y = self.view.center.y
        let width = CGFloat(50.0)
        let height = CGFloat(50.0)
        
        activityIndicatorView = NVActivityIndicatorView(frame: CGRectMake(x, y, width, height), type: .BallClipRotatePulse, color: ThemeColor, size: CGSizeMake(50, 50))
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
        
        headerView = ZFHeaderView(frame: CGRectMake(0, -60, ScreenWidth, 60))
        //先隐藏，待web加载完毕后显示
        headerView.hidden = true
        self.webView.scrollView.addSubview(headerView)
        
        footerView = ZFFooterView(frame: CGRectMake(0, 0, ScreenWidth, 60))
        //先隐藏，待web加载完毕后显示
        footerView.hidden = true
        self.webView.scrollView.addSubview(footerView)
        
    }

    func setupZan() {
        zanBtn.zanImage = UIImage(named: "News_Navigation_Vote")
        zanBtn.zanedImage = UIImage(named: "News_Navigation_Voted")
        //赞
        zanBtn.zanAction = { [unowned self](number) -> Void in
            self.zanNumLabel.text = "\(number)"
            self.zanNumLabel.textColor = ThemeColor
            self.zanNumLabel.text = "\(number)"
        }
        //取消赞
        zanBtn.unzanAction = { [unowned self](number)->Void in
            self.zanNumLabel.text = "\(number)"
            self.zanNumLabel.textColor = UIColor.lightGrayColor()
            self.zanNumLabel.text = "\(number)"
        }
        zanBtn.dk_backgroundColorPicker = BG_COLOR
    }
    
    func getNewsWithId(newsId : String!) {

        activityIndicatorView.startAnimation()
        self.isLoading = true
        
        //获取新闻详情
        viewModel.loadNewsDetail(newsId, complate: { [unowned self](newsDetail) -> Void in
            
            if let img = newsDetail.image {
                self.hasPic = true
                self.backgroundImg.hidden = false
                self.titleLabel.text = newsDetail.title!
                LightStatusBar()
                self.backgroundImg.kf_setImageWithURL(NSURL(string: img)!, placeholderImage: UIImage(named: "avatar"))
                self.webView.scrollView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0)
            }else {
                self.hasPic = false
                self.backgroundImg.hidden = true
                BlackStatusBar()
                self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            }

            //配置header和footer
            self.configHederAndFooterView()
            
            if var body = newsDetail.body {
                if let css = newsDetail.css {
                    if !self.isNight {
                        //白天模式
                        body = "<html><head><link rel='stylesheet' href='\(css[0])'></head><body>\(body)</body></html>"
                    }else {
                        //夜间模式
                        body = "<html><head><link rel='stylesheet' href='\(css[0])'></head><body><div class='night'>\(body)</div></body></html>"
                    }
                }
                print("\(body)")
                
                self.webView.loadHTMLString(body, baseURL: nil)
            }
            
            }) { (error) -> Void in
        }
        
        /// 获取新闻额外信息
        viewModel.loadNewsExra(newsId, complate: { [unowned self](newsExtra) -> Void in
            self.newsExtra = newsExtra
            self.commentNumLabel.text = "\(newsExtra.comments!)"
            self.zanBtn.initNumber = newsExtra.popularity!
            self.zanNumLabel.text = "\(newsExtra.popularity!)"
            }) { (error) -> Void in
        }

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        navView.hidden = true
        closeTheDrawerGesture()
    }
 
    
    // MARK: - Action
    // 返回
    @IBAction func didClickLeft(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // 下一条新闻
    @IBAction func didClickNext() {
        getNextNews()
    }
    // 分享
    @IBAction func didClickShare(sender: UIButton) {
        print("分享")
    }

    /**
     配置header 和 footerview
     */
    func configHederAndFooterView() {
        // 配置header
        headerView.configTintColor(hasPic)
        
        if viewModel.hasPrevious {
            headerView.hasHeaderData()
        }else {
            headerView.notiNoHeaderData()
        }
        
        if viewModel.hasNext {
            footerView.hasMoreData()
            nextNewsBtn.enabled = true
        }else {
            footerView.notiNoMoreData()
            nextNewsBtn.enabled = false
        }
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        //显示header和footer
        footerView.hidden = false
        headerView.hidden = false
        activityIndicatorView.stopAnimation()
        self.isLoading = false
        footerView.y = webView.scrollView.contentSize.height
    }
    
    // MARK: - 下一条新闻
    func getNextNews() {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: { () -> Void in
            self.containerView.frame = CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight);
            self.getNewsWithId(self.viewModel.nextId)
        }) { (finished) -> Void in
            if !self.hasPic {
                if self.isNight {
                    LightStatusBar()
                }else {
                    BlackStatusBar()
                }
            }
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.containerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            }
        }
    }
    
    // MARK: - 上一条新闻
    func getPreviousNews() {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: { () -> Void in
            self.containerView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
            self.getNewsWithId(self.viewModel.previousId)
            }) { (finished) -> Void in
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) {
                    self.containerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
                }
        }
        
    }

    // MARK: - UIScrollDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        //有图模式
        if hasPic {
            if (Float)(offSetY) >= 170 {
                
                if !self.isNight {
                    //白天模式
                    BlackStatusBar()
                }else  {
                    //夜间模式
                    LightStatusBar()
                }
                statusView.dk_backgroundColorPicker = BG_COLOR
            }else {
                LightStatusBar()
                statusView.backgroundColor = UIColor.clearColor()
            }
        }else { //无图模式
            statusView.dk_backgroundColorPicker = BG_COLOR
            if !self.isNight {
                //白天模式
                BlackStatusBar()
            }else {
                //夜间模式
                LightStatusBar()
            }
        }
        
        //到－80 让webview不再能被拉动
        if (-offSetY > 60) {
            self.webView.scrollView.contentOffset = CGPointMake(0, -60);
        }
        
        //改变header下拉箭头的方向
        if (-offSetY >= 40 ) {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.headerView.arrowImageView.transform = CGAffineTransformMakeRotation((CGFloat)(M_PI))
            })
        }else if -offSetY < 40 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.headerView.arrowImageView.transform = CGAffineTransformIdentity
            })
        }
        //改变footer下拉箭头的方向
        if offSetY + ScreenHeight - 100 > scrollView.contentSize.height {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.footerView.arrowImageView.transform = CGAffineTransformMakeRotation((CGFloat)(M_PI))
            })
        }else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.footerView.arrowImageView.transform = CGAffineTransformIdentity
            })
        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        if (-offSetY <= 60 && -offSetY >= 40 ) {
            if !viewModel.hasPrevious {
                return
            }
            if self.isLoading {
                return
            }
            self.isLoading = true
            //上一条新闻
            getPreviousNews()
        }else if (-offSetY > 60) {//到－80 让webview不再能被拉动
            self.webView.scrollView.contentOffset = CGPointMake(0, -60);
        }
        
        if (offSetY + ScreenHeight - 100 > scrollView.contentSize.height) {
            if !viewModel.hasNext {
                return
            }
            if self.isLoading {
                return
            }
            self.isLoading = true
            getNextNews()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let commentVC = segue.destinationViewController as! ZFNewsCommentViewController
        commentVC.commentNum = String(self.newsExtra.comments!)
        commentVC.newsId = self.newsId
    }
    

}
