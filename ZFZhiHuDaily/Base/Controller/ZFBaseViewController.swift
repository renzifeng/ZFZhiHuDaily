//
//  ZFBaseViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/6.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFBaseViewController: UIViewController {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var navView : UIView!
    var statusView : UIView!
    var navCenterView : UIView!
    var navTitle : UILabel!
    var refreshView : CircleRefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        setupNavView()
        // Do any additional setup after loading the view.
    }
    
    func createLeftNavWithImage(imageName : String) {
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.frame = CGRectMake(20, 27, 30, 30);
        btn.addTarget(self, action: "didClickLeft", forControlEvents: .TouchUpInside)
        self.view.addSubview(btn)
    }

    func didClickLeft() {
        appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func openTheDrawerGesture() {
        appDelegate.drawerController.openDrawerGestureModeMask = .All
    }
    
    func closeTheDrawerGesture() {
        appDelegate.drawerController.openDrawerGestureModeMask = .None
    }
    
    func setupNavView() {
        statusView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 20))
        statusView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(statusView)
        
        navView = UIView(frame: CGRectMake(0, 20, ScreenWidth, 44))
        navView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(navView)
        
        navCenterView = UIView()
        navView.backgroundColor = UIColor.clearColor()
        navCenterView.frame = CGRectMake(ScreenWidth/2-100, 0, 200, 44)
        navView.addSubview(navCenterView)
        
        navTitle = UILabel()
        navTitle.textColor = UIColor.whiteColor()
        navTitle.font = FONT(18)
        navTitle.text = "今日热闻"
        navTitle.textAlignment = .Center
        self.navCenterView.addSubview(navTitle)
        navTitle.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(navCenterView)
        }

        
        refreshView = CircleRefreshView()
        self.navCenterView.addSubview(refreshView)
        refreshView.frame = CGRectMake(10, 0, 20, 20)
        refreshView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.navTitle).offset(-30)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalTo(navCenterView)
        }
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
