//
//  ZFNewsDetailViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/12.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFNewsDetailViewController: ZFBaseViewController,UIWebViewDelegate,ParallaxHeaderViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    var newsId : String!
    var viewModel = ZFNewsDetailViewModel()
    var backgroundImg : UIImageView!
    var heardView : ParallaxHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        //左侧item
        createLeftNavWithImage("News_Arrow")
        backgroundImg = UIImageView()
        backgroundImg.contentMode = .ScaleAspectFill
        backgroundImg.frame = CGRectMake(0, 0, ScreenWidth, 164)
        
        
        //初始化Header
        heardView = ParallaxHeaderView(style: .Default, subView: backgroundImg, headerViewSize: CGSizeMake(self.view.frame.width, CGFloat(IN_WINDOW_HEIGHT)), maxOffsetY: -64, delegate:self)
        
        self.webView.scrollView.addSubview(heardView)
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        
        self.navigationController?.navigationBar.setMyBackgroundColor(RGBA(0, 130, 210, 0))
        viewModel.loadNewsDetail(self.newsId, complate: { (newsDetail) -> Void in
            self.backgroundImg.yy_setImageWithURL(NSURL(string: newsDetail.image!), placeholder: UIImage(named: "avatar"))
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
        // Do any additional setup after loading the view.
    }
    // MARK: - Action
    
    override func didClickLeft() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
      
        //调整字号
        let str = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"
        webView.stringByEvaluatingJavaScriptFromString(str)
        //js方法遍历图片添加点击事件 返回图片个数
        let aa =  "function getImages(){var objs = document.getElementsByTagName(\("img"));for(var i=0;i<objs.length;i++){objs[i].onclick=function(){document.location=\("myweb:imageClick:")+this.src;};};return objs.length;};";
        webView.stringByEvaluatingJavaScriptFromString(aa)
        webView.stringByEvaluatingJavaScriptFromString("getImages()")
    }
    
    // MARK: - ParallaxHeaderViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        heardView.layoutHeaderViewWhenScroll(scrollView.contentOffset)
        
    }
    func LockScorllView(maxOffsetY: CGFloat) {
        self.webView.scrollView.contentOffset.y = maxOffsetY
    }
    func autoAdjustNavigationBarAplha(aplha: CGFloat) {
        self.navigationController?.navigationBar.setMyBackgroundColorAlpha(aplha)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
