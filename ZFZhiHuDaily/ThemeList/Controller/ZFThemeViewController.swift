//
//  ZFThemeViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/11.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFThemeViewController: ZFBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    /// 传参model
    var theme : ZFTheme!
    /// viewModel
    private var viewModel : ZFThemeListViewModel! = ZFThemeListViewModel()
    /// tableView数据源
    var listArray : [ThemeStories] = []
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setMyBackgroundColor(RGBA(0, 130, 210, 0))
        self.navigationItem.title = theme.name
        self.tableView.delegate = viewModel
        self.tableView.dataSource = viewModel
        viewModel.tableView = self.tableView;
        viewModel.getListData(String(theme.id), successBlock: { (dataSources) -> Void in
            let list = dataSources 
            self.listArray = list.stories!
            self.tableView.reloadData()
            }) { (error) -> Void in
                
        }
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
