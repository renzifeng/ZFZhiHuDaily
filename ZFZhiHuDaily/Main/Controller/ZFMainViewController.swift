//
//  ZFMainViewController.swift
//  ZFZhiHuDaily
//
//  Created by 任子丰 on 16/1/6.
//  Copyright © 2016年 任子丰. All rights reserved.
//

import UIKit

class ZFMainViewController: ZFTableViewController, UITableViewDelegate, UITableViewDataSource ,ParallaxHeaderViewDelegate{
    var cyclePictureView: CyclePictureView!
    var imageURLArray : [String] = []
    var imageTitleArray : [String] = []
    var dateIndex : Int = 1
    @IBOutlet weak var tableView: UITableView!

    //ViewModel
    private var viewModel : ZFMainViewModel! = ZFMainViewModel()
    //轮播图数据源
    var headerSource : [ZFNews] = []
    //table数据源
    var dataSoure : [[ZFNews]] = []
    //是否正在刷新
    var isLoading : Bool! = false
    //存放header（日期）的数组
    var headerTitleArray : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        setRefreshView()
        //左侧item
        createLeftNavWithImage("Home_Icon")
        //获取数据源
        viewModel.getData({(dataSoure,headerSource) -> Void in
            print("---\(dataSoure)")
            self.dataSoure.insert(dataSoure, atIndex: 0)
            self.headerSource = headerSource
            self.setTableHeaderData()
            self.tableView.reloadData()
            }) { (error) -> Void in 
        }
        
        //设置navbar颜色
        self.navigationController?.navigationBar.setMyBackgroundColor(RGBA(0, 130, 210, 0))
        //初始化轮播图
        cyclePictureView = CyclePictureView(frame: CGRectMake(0, 0, self.view.frame.width, 164), imageURLArray: nil)
        cyclePictureView.backgroundColor = UIColor.redColor()
        cyclePictureView.currentDotColor = ThemeColor
        
        //初始化Header
        let heardView = ParallaxHeaderView(style: .Default, subView: cyclePictureView, headerViewSize: CGSizeMake(self.view.frame.width, 164), maxOffsetY: -64, delegate:self)
        
        self.tableView.tableHeaderView = heardView
    }
    
    //轮播图数据源
    func setTableHeaderData() {
        
        for news:ZFNews in self.headerSource {
            imageURLArray.append(news.images![0])
            imageTitleArray.append(news.title)
        }
        cyclePictureView.imageURLArray = imageURLArray
        cyclePictureView.imageDetailArray = imageTitleArray
        cyclePictureView.timeInterval = 3

    }
    
    func setRefreshView() {
        self.navigationController?.navigationBar.addSubview(self.titleView)
        self.navigationItem.titleView?.backgroundColor = UIColor.grayColor();
        self.titleView.addSubview(self.navTitleLabel)
        self.titleView.addSubview(self.refreshView)
    }
    // MARK: - Action
    //打开抽屉
    override func didClickLeft() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    //下拉刷新
    func updateData() {
        print("下拉刷新")
        //获取数据源
        viewModel.getData({(dataSoure,headerSource) -> Void in
            print("---\(dataSoure)")
            //先清空第一个数据源
            self.dataSoure.removeFirst()
            self.headerSource.removeAll()
            self.imageURLArray.removeAll()
            self.imageTitleArray.removeAll()
            self.dataSoure.insert(dataSoure, atIndex: 0)
            self.headerSource = headerSource
            self.setTableHeaderData()
            self.refreshView.endRefreshing()
            self.tableView.reloadData()
            }) { (error) -> Void in
        }
    }
    //上拉加载
    func pullMoreData() {
        if self.isLoading == true {
            return;
        }
        self.isLoading = !self.isLoading
        print("上拉加载")
        viewModel.getDataForDate( dateIndex, successCallBack: { (dataSoure,dateStr) -> Void in
            self.dateIndex++
            self.isLoading = !self.isLoading
            self.dataSoure.append(dataSoure)
            self.headerTitleArray.append(dateStr)
            self.tableView.reloadData()
            self.refreshView.endRefreshing()
            }) { (error) -> Void in
                
        }
        dispatch_after(GCD_Delay(2), dispatch_get_main_queue()) {
        }
        
    }
    
    /********************************** Delegate Methods ***************************************/
    // MARK: - UITableView Delegate 
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSoure.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = self.dataSoure[section]
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ZFHomeCell = tableView.dequeueReusableCellWithIdentifier("homeCell") as! ZFHomeCell
        let array = self.dataSoure[indexPath.section]
        cell.news = array[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let headerView = UIView()
            headerView.backgroundColor = ThemeColor
            let titleLabel = UILabel()
            titleLabel.text = self.headerTitleArray[section-1]
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.textAlignment = .Center
            titleLabel.frame = CGRectMake(0, 0, ScreenWidth, 44)
            headerView.addSubview(titleLabel)
            return headerView
        }else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if section != 0 {
//            self.navTitleLabel.text = self.headerTitleArray[section-1]
//            //self.titleView.x = 0
//            self.titleView.width = navTitleLabel.width
//            self.navTitleLabel.centerY = self.titleView.centerX
//            navTitleLabel.centerX = 22;
//            navTitleLabel.sizeToFit();
//        }else {
//            self.navTitleLabel.text = "今日新闻"
//            navTitleLabel.sizeToFit();
//        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
//        if section != 0 {
//            self.navTitleLabel.text = self.headerTitleArray[section-1]
//            navTitleLabel.sizeToFit();
//        }else {
//            self.navTitleLabel.text = "今日新闻"
//            navTitleLabel.sizeToFit();
//        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let heardView = self.tableView.tableHeaderView as! ParallaxHeaderView
        heardView.layoutHeaderViewWhenScroll(scrollView.contentOffset)
        let offSetY = scrollView.contentOffset.y;
        // 上拉加载
        if (offSetY  > scrollView.contentSize.height - 1.5 * ScreenHeight) {
            pullMoreData()
        }
    }
    
    // MARK: - ParallaxHeaderViewDelegate
    
    func LockScorllView(maxOffsetY: CGFloat) {
        self.tableView.contentOffset.y = maxOffsetY
    }
    func autoAdjustNavigationBarAplha(aplha: CGFloat) {
        self.navigationController?.navigationBar.setMyBackgroundColorAlpha(aplha)
    }

     // MARK:- CirCleViewDelegate Methods
    
    func clickCurrentImage(currentIndxe: Int) {
        print(currentIndxe);
    }

    // MARK:- Getter Methods
    
    private lazy var navTitleLabel : UILabel = {
        let navTitleLabel = UILabel()
        navTitleLabel.attributedText = NSAttributedString(string: "今日热闻", attributes: [NSFontAttributeName : FONT(18),NSForegroundColorAttributeName : UIColor.whiteColor()])
        navTitleLabel.sizeToFit();
//        navTitleLabel.textColor = UIColor.whiteColor()
//        navTitleLabel.font = FONT(18)
//        navTitleLabel.text = "今日热闻"
        navTitleLabel.centerX = self.view.centerX;
        navTitleLabel.centerY = 22;
        self.titleView.width = navTitleLabel.width + 30
        return navTitleLabel
    }()
    
    private lazy var refreshView : CircleRefreshView = {
        let refreshView = CircleRefreshView.attachObserveToScrollView(self.tableView, target: self, action: "updateData")
        refreshView.frame = CGRectMake(10, 0, 20, 20);
        refreshView.centerY = 22;
        refreshView.x = self.navTitleLabel.x - 30
        return refreshView
    }()
    
    private lazy var titleView : UIView = {
        let titleView = UIView()
        return titleView
    }()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
