//
//  ZFNewsCommentViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/27.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFNewsCommentViewController: ZFBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var commentNum : String!
    /// 新闻id
    var newsId : String!
    var viewModel = ZFNewsCommentViewModel()
    var comments: [ZFComments] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true;
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        viewModel.getLongComment(self.newsId) { [weak self](commentsArray) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.comments.appendContentsOf(commentsArray)
            strongSelf.tableView.reloadData()
        }
        navTitle.text = self.commentNum + "条点评"
        tableView.dk_separatorColorPicker = TAB_SEPAROTOR
        tableView.dk_backgroundColorPicker = CELL_COLOR
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navView.dk_backgroundColorPicker = TAB_HEADER
        statusView.dk_backgroundColorPicker = TAB_HEADER
        navView.hidden = false
        refreshView.hidden = true
        LightStatusBar()
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        LightStatusBar()
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

// MARK: - UITableViewDelegate
extension ZFNewsCommentViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

// MARK: - UITableViewDataSource
extension ZFNewsCommentViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ZFCommentCell") as! ZFCommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }

}