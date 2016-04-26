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

class ZFDrawerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    /// 收藏Btn
    @IBOutlet weak var collectBtn: ImageTextButton!
    /// 消息Btn
    @IBOutlet weak var msgBtn: ImageTextButton!
    /// 设置Btn
    @IBOutlet weak var settingBtn: ImageTextButton!
    /// 离线Btn
    @IBOutlet weak var offlineBtn: ImageTextButton!
    /// 夜间模式Btn
    @IBOutlet weak var themeBtn: ImageTextButton!
    /// headerView
    @IBOutlet weak var headerView: UIView!
    /// footerView
    @IBOutlet weak var footerView: UIView!
    //头像
    @IBOutlet weak var avatarImg: UIImageView!
    //mainVC
    weak var mainVC : MMViewController!
    
    var dataSoure : [ZFTheme] = []
    //ViewModel
    private var viewModel : ZFThemeViewModel! = ZFThemeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getData({ [weak self](dataSoure) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.dataSoure = dataSoure
            strongSelf.tableView.reloadData()
            /// 默认选择第0个
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            strongSelf.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .None)
            }) { (error) -> Void in
                
        }
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
        
        //切圆角
        cutRoundWith(avatarImg)

        //去掉下部空白格
        tableView.tableFooterView = UIView()
        
        if ((NSUserDefaults.standardUserDefaults().objectForKey("NightOrLightMode")) == nil) {
            //白天模式
            DKNightVersionManager.dawnComing()
            NSUserDefaults.standardUserDefaults().setObject("light", forKey: "NightOrLightMode")
            lightMode()
        }else {
            let mode = NSUserDefaults.standardUserDefaults().objectForKey("NightOrLightMode") as! String
            if mode == "light"{
                //白天模式
                DKNightVersionManager.dawnComing()
                lightMode()
            }else if mode == "night" {
                DKNightVersionManager.nightFalling()
                nightModel()
            }
        }

    }
    //离线功能
    @IBAction func cacheData() {
        
    }
    
    //夜间模式、白天模式
    @IBAction func changeTheme(sender: ImageTextButton) {
        if (DKNightVersionManager.currentThemeVersion() == .Night) {
            DKNightVersionManager.dawnComing()
            NSUserDefaults.standardUserDefaults().setObject("light", forKey: "NightOrLightMode")
            lightMode()
        }else {
            DKNightVersionManager.nightFalling()
            NSUserDefaults.standardUserDefaults().setObject("night", forKey: "NightOrLightMode")
            nightModel()
        }
    }
    
    func lightMode() {
        themeBtn.setImage(UIImage(named: "Menu_Dark"), forState: .Normal)
        themeBtn.setTitle("夜间", forState: .Normal)
    }
    
    func nightModel() {
        themeBtn.setImage(UIImage(named: "Menu_Day"), forState: .Normal)
        themeBtn.setTitle("白天", forState: .Normal)
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

// MARK: - UITableViewDelegate
extension ZFDrawerViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.mainVC.setCenterViewController(self.mainVC.centerVC, withCloseAnimation: true, completion: nil)
        }else {
            let theme : ZFTheme = self.dataSoure[indexPath.row-1]
            let naviVC = GET_SB("Main").instantiateViewControllerWithIdentifier("ZFThemeNav") as! ZFBaseNavigationController
            let themeVC = naviVC.viewControllers[0] as! ZFThemeViewController
            themeVC.theme = theme
            self.mainVC.setCenterViewController(naviVC, withCloseAnimation: true, completion: nil)
        }
        
    }

}

// MARK: - UITableViewDataSource
extension ZFDrawerViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSoure.count+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell : ZFLeftHomeCell? = tableView.dequeueReusableCellWithIdentifier("leftHome") as? ZFLeftHomeCell
            return cell!;
        }else {
            let cell : LeftCell? = tableView.dequeueReusableCellWithIdentifier("left") as? LeftCell
            let theme : ZFTheme = self.dataSoure[indexPath.row-1]
            cell!.theme = theme
            return cell!;
        }
    }
}