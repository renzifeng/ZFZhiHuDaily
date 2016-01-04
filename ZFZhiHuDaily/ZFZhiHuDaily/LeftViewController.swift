//
//  LeftViewController.swift
//  MMDrawerControllerDemo
//
//  Created by wjl on 15/11/13.
//  Copyright © 2015年 Martin. All rights reserved.
//
/*
    Github： https://github.com/Wl201314
    微博：http://weibo.com/5419850564/profile?rightmod=1&wvr=6&mod=personnumber
    请持续关注，代码会进行重构优化
*/
import UIKit

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
  
    func setTableView(){
        
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth * 0.7, view.frame.height), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(tableView)
        
        //设置headView
        let headImageViewHight: CGFloat = 160
        let headImageView = UIImageView(frame: CGRectMake(0, 0, ScreenWidth * 0.7, headImageViewHight))
        headImageView.image = UIImage(named: "quesheng")
        
        tableView.tableHeaderView = headImageView
        //去掉下部空白格
        self.tableView.tableFooterView = UIView()

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil {
            cell=UITableViewCell(style: .Value1, reuseIdentifier: identifier)
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle = .None
        }
        if indexPath.row == 0{
            cell!.imageView!.image = UIImage(named: "Done")
            cell!.textLabel?.text = "我的主页"
        }
        else{
            cell!.imageView!.image = UIImage(named: "Done")
            cell!.textLabel?.text = "通用侧滑"
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        switch (indexPath.row){
        case 0:
            let centerViewController = CenterViewController()
            let centerNavigationController = UINavigationController(rootViewController: centerViewController)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.drawerController.centerViewController = centerNavigationController
            appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        default:
            
            let otherViewController = OtherViewController()
            let otherNavigationController = UINavigationController(rootViewController: otherViewController)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.drawerController.centerViewController = otherNavigationController
            appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        }
        
    }
    

}
