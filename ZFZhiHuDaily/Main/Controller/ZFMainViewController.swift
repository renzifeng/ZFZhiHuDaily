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
    @IBOutlet weak var tableView: UITableView!
    //var refreshControl : RefreshControl!
    //weak var mainTitleViewController : MainTitleViewController?
    //ViewModel
    private var viewModel : ZFMainViewModel! = ZFMainViewModel()
    //轮播图数据源
    var headerSource : [ZFNews] = []
    //table数据源
    var dataSoure : [ZFNews] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        //左侧item
        createLeftNavWithImage("Home_Icon")
        //获取数据源
        viewModel.getData({(dataSoure,headerSource) -> Void in
            print("---\(dataSoure)")
            self.dataSoure = dataSoure
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
        //初始化Header
        let heardView = ParallaxHeaderView(style: .Default, subView: cyclePictureView, headerViewSize: CGSizeMake(self.view.frame.width, 164), maxOffsetY: -164, delegate:self)
        
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
        cyclePictureView.timeInterval = 103

    }
    
    // MARK: - Action
    
    override func didClickLeft() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSoure.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ZFHomeCell = tableView.dequeueReusableCellWithIdentifier("homeCell") as! ZFHomeCell
        cell.news = self.dataSoure[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
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

    /********************************** Delegate Methods ***************************************/
     //MARK:- Delegate Methods
     //MARK:- CirCleViewDelegate Methods
    
    func clickCurrentImage(currentIndxe: Int) {
        print(currentIndxe);
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
