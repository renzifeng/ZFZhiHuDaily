//
//  ZFMainViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/6.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFMainViewController: ZFTableViewController, UITableViewDelegate, UITableViewDataSource ,ParallaxHeaderViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var refreshControl : RefreshControl!
    weak var mainTitleViewController : MainTitleViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        //左侧item
        createLeftNavWithImage("Home_Icon")
        
//        refreshControl = RefreshControl(scrollView: tableView, delegate: self)
//        refreshControl.topEnabled = true
//        refreshControl.bottomEnabled = true
//        refreshControl.registeTopView(mainTitleViewController!)
//        refreshControl.enableInsetTop = SCROLL_HEIGHT
//        refreshControl.enableInsetBottom = 30
        self.navigationController?.navigationBar.setMyBackgroundColor(RGBA(0, 130, 210, 0))
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.tableView.bounds.width, 100))
        imageView.image = UIImage(named: "ThemeImage")
        imageView.contentMode = .ScaleAspectFill
        
        let heardView = ParallaxHeaderView(style: .Default, subView: imageView, headerViewSize: CGSizeMake(self.tableView.bounds.width, 100), maxOffsetY: -120, delegate:self)
        
        self.tableView.tableHeaderView = heardView
    }
    
    // MARK: - Action
    
    override func didClickLeft() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell")
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let heardView = self.tableView.tableHeaderView as! ParallaxHeaderView
        heardView.layoutHeaderViewWhenScroll(scrollView.contentOffset)
        
    }
    
    func LockScorllView(maxOffsetY: CGFloat) {
        self.tableView.contentOffset.y = maxOffsetY
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
