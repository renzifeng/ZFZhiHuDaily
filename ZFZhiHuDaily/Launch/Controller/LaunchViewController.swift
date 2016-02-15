//
//  LaunchViewController.swift
//  zhihuDaily 2.0
//
//  Created by Nirvana on 10/1/15.
//  Copyright © 2015 NSNirvana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LaunchViewController: UIViewController, JSAnimatedImagesViewDataSource {

    @IBOutlet weak var animatedImagesView: JSAnimatedImagesView!
    @IBOutlet weak var text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //如果已有下载好的文字则使用
        text.text = NSUserDefaults.standardUserDefaults().objectForKey(Keys.launchTextKey) as? String
        
        //下载下一次所需的启动页数据
        
        ZFNetworkTool.get(START_IMAGE, params: nil, success: { (json) -> Void in
            //print("\(json)")
            //拿到text并保存
            let text = json["text"] as! String
            self.text.text = text
            NSUserDefaults.standardUserDefaults().setObject(text, forKey: Keys.launchTextKey)
            
            //拿到图像URL后取出图像并保存
            let launchImageURL = json["img"] as! String
            //同步调用URL,获取开始图片的JSON结果
            var data: NSData?
            do {
                data = try NSURLSession.sharedSession().sendSynchronousDataTaskWithURL(NSURL(string: launchImageURL)!)
            } catch _ {
                data = nil
            }

            //把NSData转换成必要的UIImage对象
            if let d = data {
                //把图片放入缓存
                NSUserDefaults.standardUserDefaults().setObject(d, forKey: Keys.launchImgKey)

            }

            }) { (error) -> Void in
                
        }
        //设置自己为JSAnimatedImagesView的数据源
        animatedImagesView.dataSource = self
        
        //半透明遮罩层
        let blurView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        blurView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.45)
        animatedImagesView.addSubview(blurView)
        
        //渐变遮罩层
        let gradientView = GradientView(frame: CGRectMake(0, self.view.frame.height / 3 * 2, self.view.frame.width, self.view.frame.height / 3 ), type: TRANSPARENT_GRADIENT_TYPE)
        animatedImagesView.addSubview(gradientView)
        
        //遮罩层透明度渐变
        UIView.animateWithDuration(2.5) { () -> Void in
            blurView.backgroundColor = UIColor.clearColor()
        }
        
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
        return 2
    }
    
    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        //如果已有下载好的图片则使用
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(Keys.launchImgKey) {
            return UIImage(data: data as! NSData)
        }
        return UIImage(named: "DemoLaunchImage")
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
