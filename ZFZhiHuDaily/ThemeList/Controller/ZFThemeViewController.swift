//
//  ZFThemeViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/11.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFThemeViewController: ZFBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    /// 传参model
    var theme : ZFTheme!
    /// viewModel
    private var viewModel : ZFThemeListViewModel! = ZFThemeListViewModel()
    /// tableView数据源
    var dataSoure : [ThemeStories] = []
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80
        self.navigationItem.title = theme.name
        self.tableView.delegate = self
        self.tableView.dataSource = self
        viewModel.tableView = self.tableView;
        viewModel.getListData(String(theme.id), successBlock: { (dataSources) -> Void in
            let list = dataSources 
            self.dataSoure = list.stories!
            self.tableView.reloadData()
            }) { (error) -> Void in
                
        }
    }

    // MARK: - UITableView Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSoure.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ZFThemeListCell") as! ZFThemeListCell
        cell.story = self.dataSoure[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
