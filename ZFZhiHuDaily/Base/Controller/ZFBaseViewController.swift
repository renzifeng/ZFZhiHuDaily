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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createLeftNavWithImage(imageName : String) {
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.frame = CGRectMake(0, 0, 30, 30);
        btn.addTarget(self, action: "didClickLeft", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    func createLeftNavWithTitle(title : String) {
        let btn = UIButton(type: .Custom)
        btn.setTitle(title, forState: .Normal)
        btn.frame = CGRectMake(0, 0, 30, 30);
        btn.addTarget(self, action: "didClickLeft", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
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
