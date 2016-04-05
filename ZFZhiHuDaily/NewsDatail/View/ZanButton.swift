//
//  ZanButton.swift
//  ClickZanButton
//
//  Created by 任子丰 on 16/1/12.
//  Copyright © 2015年 任子丰. All rights reserved.
//

import UIKit

class ZanButton: UIView{

    private var zanImageView:UIImageView!
    
    private var zanNotifyView:UIView!
    
    private var numberView:NumberScrollAnimatedView!
    
    /// 点赞的时候的动作闭包
    var zanAction:((Int)->Void)?
    
    /// 点取消赞的时候的动作
    var unzanAction:((Int)->Void)?
    
    /// 点赞之前的图标
    var zanImage:UIImage! {
        didSet{
            if !isZan {
                zanImageView.image = zanImage
            }
        }
    }
    
    ///  点赞后的图标
    var zanedImage:UIImage! {
        didSet{
            if  isZan {
                zanImageView.image = zanedImage
            }
        }
    }
    
    /// 是否已点赞
    var isZan = false
    
    var initNumber:Int {
        
        get {
            return zanNumber
        }
        
        set{
            zanNumber = newValue
            self.numberView.value = zanNumber
        }
    }
    
    /// 赞的数量
    private var zanNumber = 0
    
    /// PopView的高度
    var popHeight:Float = 20.0
    /// PopView的背景色
    var popBackgroundColor = RGB(4, 179, 244)
    /// PopView的圆角
    var popCornerRadius:Float = 2.0
    /// PopView的字体
    var popFont = UIFont.systemFontOfSize(10)
    /// PopView的字体颜色
    var popFontColor = UIColor.whiteColor()
    /// PopView中字体跳动的动画持续时间
    var popNumberDuration:Float = 0.4
    var popShowDuration:Float = 0.3
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initBaseLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBaseLayout()
    }
    
    /**
    初始化控件
    
    - returns:
    */
    private func initBaseLayout(){
        
        //设置图片
        zanImageView = UIImageView(frame: CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)))
        zanImageView.contentMode = UIViewContentMode.Center
        
        zanImageView.userInteractionEnabled = true
        self.addSubview(zanImageView)
        
        if zanImage == nil {
            zanImage = UIImage(named: "News_Navigation_Vote")
        }
        
        if zanedImage == nil {
            zanedImage = UIImage(named: "News_Navigation_Voted")
        }
        
        //设置点击事件
        let tapImageViewGesture = UITapGestureRecognizer(target: self, action: #selector(ZanButton.zanAnimationPlay))
        
        zanImageView.addGestureRecognizer(tapImageViewGesture)
        
        //开始构建
        zanNotifyView = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(self.frame), CGFloat(popHeight)))
        zanNotifyView.backgroundColor=popBackgroundColor
        
        //设置圆角矩形
        let corner = CGFloat(popCornerRadius)
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: zanNotifyView.bounds, byRoundingCorners: .AllCorners, cornerRadii:CGSizeMake(corner,corner))
        shapeLayer.path = path.CGPath
        zanNotifyView.layer.mask = shapeLayer

        //先是设置为隐藏
        zanNotifyView.alpha=0
        
        //开始设置数字了
        numberView = NumberScrollAnimatedView(frame: CGRectMake(0, 0, CGRectGetWidth(self.frame), CGFloat(popHeight)))
        numberView.backgroundColor = UIColor.clearColor()
        numberView.font = popFont
        numberView.textColor = popFontColor
        numberView.desity = 0
        numberView.duration = popNumberDuration
        numberView.value = zanNumber
        
        zanNotifyView.addSubview(numberView!)
        
        self.addSubview(zanNotifyView)
    }
    
    /**
    开始执行点赞动画
    */
    func zanAnimationPlay(){
        
        //点击取反
        self.isZan = !self.isZan
        
        if self.isZan {
            //赞的数量加1
            self.zanNumber += 1
            
            //开始执行动画
            UIView.animateWithDuration(NSTimeInterval(popShowDuration), animations: { () -> Void in
                //第一阶段动画效果,用于显示popView
                self.zanNotifyView?.frame = CGRectMake(0, -30, CGRectGetWidth(self.frame), CGFloat(self.popHeight))
                self.zanNotifyView?.alpha = 1
                }, completion: { (finished) -> Void in
                    //完成第一阶段动画后, 开始跳动数字
                    
                    self.numberView.value = self.zanNumber
                    self.numberView.startAnimation({()->Void in
                        //数字跳动完成后,开始 第二阶段动画, 用于popView的消失
                        UIView.animateWithDuration(NSTimeInterval(self.popShowDuration), animations: { () -> Void in
                            //动画效果
                            self.zanNotifyView?.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGFloat(self.popHeight))
                            self.zanNotifyView?.alpha = 0
                            
                            }, completion: { (finished) -> Void in
                                //完成
                                
                        })
                    })
            })
            
            if let _zanAction = zanAction {
                _zanAction(self.zanNumber)
            }
            self.zanImageView?.image = zanedImage
        }else{
            //如果是取消赞的操作
            self.zanNumber -= 1
            self.numberView.value = self.zanNumber
            self.zanImageView?.image = zanImage
            
            if  let _unzanAction = unzanAction {
                _unzanAction(self.zanNumber)
            }
        }
    }
}
