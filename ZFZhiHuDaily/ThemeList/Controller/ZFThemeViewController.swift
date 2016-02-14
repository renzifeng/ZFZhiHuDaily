//
//  ZFThemeViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/11.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import Kingfisher

class ZFThemeViewController: ZFBaseViewController,UITableViewDelegate,UITableViewDataSource,ParallaxHeaderViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    /// 传参model
    var theme : ZFTheme!
    /// viewModel
    private var viewModel : ZFThemeListViewModel! = ZFThemeListViewModel()
    /// tableView数据源
    var dataSoure : [ZFThemeStories] = []
    var backgroundImg : UIImageView!
   
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //左侧item
        createLeftNavWithImage("News_Arrow")
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.rowHeight = 80
        //设置navbar颜色
        self.navigationController?.navigationBar.setMyBackgroundColor(RGBA(0, 130, 210, 0))
        setTableHeader()
        setRefreshView()
        viewModel.tableView = self.tableView;
        viewModel.getListData(String(theme.internalIdentifier!), successBlock: { (dataSources) -> Void in
            let list = dataSources
            self.backgroundImg.kf_setImageWithURL(NSURL(string: list.background!)!, placeholderImage: UIImage(named: "avatar"))
            self.dataSoure = list.stories!
            self.tableView.reloadData()
            }) { (error) -> Void in
                
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        LightStatusBar()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        LightStatusBar()
        openTheDrawerGesture()
    }
    
    //tableHader
    func setTableHeader() {
        backgroundImg = UIImageView()
        backgroundImg.contentMode = .ScaleAspectFill
        backgroundImg.frame = CGRectMake(0, 0, ScreenWidth, 100)
        //初始化Header
        let heardView = ParallaxHeaderView(style: .Thumb, subView: backgroundImg, headerViewSize: CGSizeMake(self.view.frame.width, 64), maxOffsetY: 93, delegate:self)
        self.tableView.tableHeaderView = heardView
    }
    
    //刷新View
    func setRefreshView() {
        navTitle.text = self.theme.name
        refreshView.attachObserveToScrollView(self.tableView, target: self, action: "updateData")
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
    // MARK: - Action
    
    //下拉刷新
    func updateData() {
        print("下拉刷新")
        //获取数据源
        viewModel.getListData(String(theme.internalIdentifier!), successBlock: { (dataSources) -> Void in
            self.dataSoure.removeAll()
            let list = dataSources
            self.backgroundImg.kf_setImageWithURL(NSURL(string: list.background!)!, placeholderImage: UIImage(named: "avatar"))
            self.dataSoure = list.stories!
            self.refreshView.endRefreshing()
            self.tableView.reloadData()
            }) { (error) -> Void in
                
        }
    }
    
    // MARK: - ParallaxHeaderViewDelegate
    
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
        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let newsDetailVC  = segue.destinationViewController as! ZFNewsDetailViewController
        let cell = sender! as! UITableViewCell
        let indexPath =  self.tableView.indexPathForCell(cell)!
        //取消cell选中
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let story = self.dataSoure[indexPath.row]
        newsDetailVC.newsId = String(story.internalIdentifier!)
    }

}
