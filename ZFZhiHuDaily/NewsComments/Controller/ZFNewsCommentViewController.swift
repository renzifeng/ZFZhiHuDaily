//
//  ZFNewsCommentViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/27.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFNewsCommentViewController: ZFBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var commentNum : String!
    /// 新闻id
    var newsId : String!
    var viewModel = ZFNewsCommentViewModel()
    var comments: [ZFComments] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
        self.navigationItem.title = self.commentNum + "条点评"
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
        viewModel.getLongComment(self.newsId) { (commentsArray) -> Void in
            self.comments.appendContentsOf(commentsArray)
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.setMyBackgroundColor(RGBA(0, 130, 210, 1))
        LightStatusBar()
    }
    
    @IBAction func popToback(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ZFCommentCell") as! ZFCommentCell
        cell.comment = self.comments[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
