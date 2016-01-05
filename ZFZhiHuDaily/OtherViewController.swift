//
//  OtherViewController.swift
//  MMDrawerControllerDemo
//
//  Created by wjl on 15/11/13.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "通用页"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Done_2"), style: UIBarButtonItemStyle.Plain, target: self, action: "doneSlide")
        self.view.backgroundColor = UIColor.grayColor()
    }
    
    func doneSlide(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
        
        
    }

}
