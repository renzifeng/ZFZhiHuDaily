//
//  MMViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/9.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class MMViewController: MMDrawerController {
    
    let centerVC = GET_SB("Main").instantiateViewControllerWithIdentifier("ZFMainNav") 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置视图
        let leftVC =  GET_SB("Left").instantiateViewControllerWithIdentifier("ZFDrawerViewController") as! ZFDrawerViewController
        
        leftVC.mainVC = self;
        
        self.centerViewController = centerVC
        self.leftDrawerViewController = leftVC
        
        self.shouldStretchDrawer = false
        
        self.maximumLeftDrawerWidth = 200
        //手势
        self.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        self.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        // Do any additional setup after loading the view.
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
