//
//  LeftViewController.swift
//  MMDrawerControllerDemo
//
//  Created by wjl on 15/11/13.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit
import SnapKit

class LeftViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.contentInset = UIEdgeInsetsMake(190, 0, 0, 0)
        setTableViewHeader()
    }
  
    func setTableViewHeader(){
        let superView = UIView()
        superView.frame = CGRectMake(0, 0, 335, 190)
        //设置headView
        let headerView : ZFLeftHeader = ZFLeftHeader.leftHeader()
        superView.addSubview(headerView)
        tableView.tableHeaderView = superView
        headerView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        //去掉下部空白格
        self.tableView.tableFooterView = UIView()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "left"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
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
