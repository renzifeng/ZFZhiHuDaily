//
//  ZFNewsCommentViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/27.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFNewsCommentViewController: ZFBaseViewController {
    
    var commentNum : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        self.navigationItem.title = self.commentNum + "条点评"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setMyBackgroundColor(RGBA(0, 130, 210, 1))
    }
    
    @IBAction func popToback(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
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
