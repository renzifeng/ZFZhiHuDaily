//
//  ZFMainViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/6.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFMainViewController: ZFTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        //创建leftBarButtonItem以及添加手势识别
        let leftButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .Plain, target: self, action: "revealToggle:")
        //如果是第一次启动
        if appCloud().firstDisplay {
            //生成第二启动页背景
            let launchView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
            launchView.alpha = 0.99
            
            //得到第二启动页控制器并设置为子控制器
            let SB = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let launchViewController = SB.instantiateViewControllerWithIdentifier("LaunchViewController")
            self.addChildViewController(launchViewController)
            
            //将第二启动页放到背景上
            launchView.addSubview(launchViewController.view)
            
            //展示第二启动页并隐藏NavbarTitleView
            self.view.addSubview(launchView)
            //UIApplication.sharedApplication().keyWindow?.addSubview(launchView)
            self.navigationItem.titleView?.hidden = true
//            self.navigationController?.navigationBarHidden = true;
            //动画效果：第二启动页2.5s展示过后经0.2秒删除并恢复展示NavbarTitleView
            UIView.animateWithDuration(2.5, animations: { () -> Void in
                launchView.alpha = 1
                }) { (finished) -> Void in
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        launchView.alpha = 0
                        self.navigationItem.titleView?.hidden = false
                        self.navigationItem.setLeftBarButtonItem(leftButton, animated: false)
                        }, completion: { (finished) -> Void in
                            launchView.removeFromSuperview()
                            self.navigationController?.navigationBar.barTintColor = RGB(50, 50, 58)
                    })
            }
            //展示完成后更改为false
            appCloud().firstDisplay = false
        } else {
            self.navigationItem.setLeftBarButtonItem(leftButton, animated: false)
        }

        //设置透明NavBar
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Other
    //获取总代理
    func appCloud() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    //设置StatusBar为白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    func revealToggle(btn: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
