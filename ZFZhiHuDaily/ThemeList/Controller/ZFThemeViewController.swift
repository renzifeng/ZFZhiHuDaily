//
//  ZFThemeViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/11.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit
import Kingfisher

class ZFThemeViewController: ZFBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    /// 传参model
    var theme : ZFTheme!
    /// viewModel
    private var viewModel : ZFThemeListViewModel! = ZFThemeListViewModel()
    /// tableView数据源
    var dataSoure : [ZFThemeStories] = []
    var backgroundImg : UIImageView!
    /// 存放内容id的数组
    var newsIdArray : [String]!
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //左侧item
        createLeftNavWithImage("News_Arrow")
        automaticallyAdjustsScrollViewInsets = false
        tableView.rowHeight = 80
        //设置navbar颜色
        navigationController?.navigationBar.setMyBackgroundColor(RGBA(0, 130, 210, 0))
        setTableHeader()
        setRefreshView()
        viewModel.tableView = tableView;
        //请求数据
        updateData()
        tableView.dk_separatorColorPicker = TAB_SEPAROTOR
        tableView.dk_backgroundColorPicker = CELL_COLOR
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
        backgroundImg.backgroundColor = UIColor.grayColor()
        backgroundImg.contentMode = .ScaleAspectFill
        backgroundImg.frame = CGRectMake(0, 0, ScreenWidth, 100)
        //初始化Header
        let heardView = ParallaxHeaderView(style: .Thumb, subView: backgroundImg, headerViewSize: CGSizeMake(view.frame.width, 64), maxOffsetY: 93, delegate:self)
        tableView.tableHeaderView = heardView
    }
    
    //刷新View
    func setRefreshView() {
        navTitle.text = theme.name
        refreshView.attachObserveToScrollView(tableView, target: self, action: #selector(ZFThemeViewController.updateData))
    }
    
    // MARK: - Action
    
    //下拉刷新
    func updateData() {
        //print("下拉刷新")
        //获取数据源
        viewModel.getListData(String(theme.internalIdentifier!), successBlock: { [weak self](dataSources) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.dataSoure.removeAll()
            let list = dataSources
            strongSelf.backgroundImg.kf_setImageWithURL(NSURL(string: list.background!)!, placeholderImage: UIImage(named: "avatar"))
            strongSelf.dataSoure = list.stories!
            strongSelf.refreshView.endRefreshing()
            strongSelf.tableView.reloadData()
            }) { (error) -> Void in
                
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let newsDetailVC  = segue.destinationViewController as! ZFNewsDetailViewController
        let cell = sender! as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)!
        //取消cell选中
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let story = dataSoure[indexPath.row]
        newsDetailVC.newsId = String(story.internalIdentifier!)
        self.newsIdArray = []
        for i in 0 ..< self.dataSoure.count {
            let story = dataSoure[i]
            newsIdArray.append((String)(story.internalIdentifier!))
        }
        newsDetailVC.newsIdArray = newsIdArray
    }

}

// MARK: - UITableViewDataSource
extension ZFThemeViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSoure.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ZFThemeListCell") as! ZFThemeListCell
        cell.story = dataSoure[indexPath.row]
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension ZFThemeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let heardView = tableView.tableHeaderView as! ParallaxHeaderView
        heardView.layoutHeaderViewWhenScroll(scrollView.contentOffset)
    }

}

// MARK: - ParallaxHeaderViewDelegate
extension ZFThemeViewController: ParallaxHeaderViewDelegate {
    func LockScorllView(maxOffsetY: CGFloat) {
        tableView.contentOffset.y = maxOffsetY
    }
    func autoAdjustNavigationBarAplha(aplha: CGFloat) {
        navigationController?.navigationBar.setMyBackgroundColorAlpha(aplha)
    }

}