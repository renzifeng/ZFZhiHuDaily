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
    @IBOutlet weak var avatarImg: UIImageView!
    var dataSoure : [ZFTheme] = []
    //ViewModel
    private var viewModel : ZFThemeViewModel! = ZFThemeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getData({(dataSoure) -> Void in
            print("---\(dataSoure)")
            self.dataSoure = dataSoure
            self.tableView.reloadData()
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
        
        avatarImg.layer.masksToBounds = true
        avatarImg.layer.cornerRadius = 25.0
        //去掉下部空白格
        self.tableView.tableFooterView = UIView()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSoure.count
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let centerViewController = GET_SB("Main").instantiateViewControllerWithIdentifier("ZFMainViewController")
        App_Delagate.drawerController.centerViewController = centerViewController
        App_Delagate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
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
