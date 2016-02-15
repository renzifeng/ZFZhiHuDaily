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
    /// 存放内容id的数组
    var newsIdArray : [String]!
    /// 新闻id
    var newsId : String!
    var viewModel = ZFNewsDetailViewModel()
    var backgroundImg : UIImageView!
    var titleLabel : UILabel!
    var heardView : ParallaxHeaderView!
    /// 新闻额外信息
    var newsExtra : ZFNewsExtra!
    /// loading
    var activityIndicatorView : NVActivityIndicatorView!
    /// 判断是否有图
    var hasPic : Bool = false
    /// 是否正在加载
    var isLoading : Bool = true
    /// 是否有下一条
    var hasNext : Bool = false
    /// 是否有上一条
    var hasPrevious : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏左侧item
        self.navigationItem.hidesBackButton = true;
        statusView.backgroundColor = UIColor.clearColor()
        navView.hidden = true
        
        backgroundImg = UIImageView()
        backgroundImg.contentMode = .ScaleAspectFill
        backgroundImg.clipsToBounds = true
        backgroundImg.frame = CGRectMake(0, -40, ScreenWidth, CGFloat(IN_WINDOW_HEIGHT+40))
        
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
        
        self.webView.scrollView.addSubview(backgroundImg)
        self.webView.scrollView.delegate = self
        
        let x = self.view.center.x
        let y = self.view.center.y
        let width = CGFloat(50.0)
        let height = CGFloat(50.0)
        
        activityIndicatorView = NVActivityIndicatorView(frame: CGRectMake(x, y, width, height), type: .BallClipRotatePulse, color: UIColor.lightGrayColor(), size: CGSizeMake(50, 50))
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
        
        //赞
        setupZan()
        
        viewModel.newsIdArray = self.newsIdArray
        getNewsWithId(self.newsId)
    }
    
    
    func getNewsWithId(newsId : String!) {
        activityIndicatorView.startAnimation()
        //获取新闻详情
        viewModel.loadNewsDetail(newsId, complate: { (newsDetail) -> Void in
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
            if  var body = newsDetail.body {
                if let css = newsDetail.css {
                    var temp = ""
                    for c in css {
                        temp = "<link href='\(c)' rel='stylesheet' type='text/css' />\(temp)"
                    }
                    //由于它的CSS中已经写死了 顶部图片的高度就是200,因此这个地方需要增加一个CSS 来根据设备的大小来改变图片的高度
                    body = "\(temp) <style> .headline .img-place-holder { height: \(IN_WINDOW_HEIGHT)px;}</style> \(body)"
                }
                
                self.webView.loadHTMLString(body, baseURL: nil)
            }
            
            }) { (error) -> Void in
        }
        
        /// 获取新闻额外信息
        viewModel.loadNewsExra(newsId, complate: { (newsExtra) -> Void in
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
    // MARK: - SetupUI
    
    func setupZan() {
        zanBtn.zanImage = UIImage(named: "News_Navigation_Vote")
        zanBtn.zanedImage = UIImage(named: "News_Navigation_Voted")
        //赞
        zanBtn.zanAction = { (number) -> Void in
            self.zanNumLabel.text = "\(number)"
            self.zanNumLabel.textColor = ThemeColor
            self.zanNumLabel.text = "\(number)"
        }
        //取消赞
        zanBtn.unzanAction = {(number)->Void in
            self.zanNumLabel.text = "\(number)"
            self.zanNumLabel.textColor = UIColor.lightGrayColor()
            self.zanNumLabel.text = "\(number)"
        }
    }
    // MARK: - Action
    
    @IBAction func didClickLeft(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicatorView.stopAnimation()
        self.isLoading = false
    }
    
    // MARK: - ParallaxHeaderViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y;
        //有图模式
        if hasPic {
            if (Float)(offSetY) >= 170 {
                statusView.backgroundColor = UIColor.whiteColor()
                BlackStatusBar()
            }else {
                LightStatusBar()
                statusView.backgroundColor = UIColor.clearColor()
            }
        }else { //无图模式
            statusView.backgroundColor = UIColor.whiteColor()
            BlackStatusBar()
        }
        
        if (-offSetY <= 40 && -offSetY >= 20) {
            if !viewModel.hasPrevious {
                return
            }
            //上一条新闻
            getPreviousNews()
            print("上一条")
        }else if (-offSetY > 40) {//到－80 让webview不再能被拉动
            self.webView.scrollView.contentOffset = CGPointMake(0, -40);
        }
        
        if (offSetY + ScreenHeight > scrollView.contentSize.height + 20  && !self.webView.scrollView.dragging) {
            if !viewModel.hasNext {
                return
            }
            getNextNews()
            print("下一条")
        }
    }


    // MARK: - 下一条新闻
    
    func getNextNews() {
        if self.isLoading {
            return
        }
        self.isLoading = true
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
            self.containerView.frame = CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight);
            self.getNewsWithId(self.viewModel.nextId)
        }) { (finished) -> Void in
            self.isLoading = false
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.containerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
            }
        }
    }
    // MARK: - 上一条新闻
    
    func getPreviousNews() {
        if self.isLoading {
            return
        }
        self.isLoading = true
        UIView.animateWithDuration(0.25, delay: 0.0, options: .CurveEaseIn, animations: { () -> Void in
            self.containerView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
            self.getNewsWithId(self.viewModel.previousId)
            }) { (finished) -> Void in
                self.isLoading = false
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) {
                    self.containerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
                }
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
