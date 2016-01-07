//
//  ZFDrawerViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/6.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class ZFDrawerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectBtn: ImageTextButton!
    @IBOutlet weak var msgBtn: ImageTextButton!
    @IBOutlet weak var settingBtn: ImageTextButton!
    @IBOutlet weak var offlineBtn: ImageTextButton!
    @IBOutlet weak var themeBtn: ImageTextButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    //ViewModel
    private var viewModel : ZFThemeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.getData({ (dataSoure) -> Void in
//            
//            }) { (error) -> Void in
//                
//        }
        setTableView()
       
    }
    func setTableView() {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        footerView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        collectBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentUp
        msgBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentUp
        settingBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentUp
        offlineBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentLeft
        themeBtn.buttonTitleWithImageAlignment = UIButtonTitleWithImageAlignmentLeft
        //去掉下部空白格
        self.tableView.tableFooterView = UIView()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell : ZFHomeCell? = tableView.dequeueReusableCellWithIdentifier("home") as? ZFHomeCell
            return cell!;
        }else {
            let cell : LeftCell? = tableView.dequeueReusableCellWithIdentifier("left") as? LeftCell
            return cell!;
        }
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
