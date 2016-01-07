
//
//  ParallaxHeaderView.swift
//  ParallaxHeaderView
//
//  Created by wl on 15/11/3.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

protocol ParallaxHeaderViewDelegate: class {
    func LockScorllView(maxOffsetY: CGFloat)
    func autoAdjustNavigationBarAplha(aplha: CGFloat)
}

extension ParallaxHeaderViewDelegate where Self : UITableViewController {
    func LockScorllView(maxOffsetY: CGFloat) {
        self.tableView.contentOffset.y = maxOffsetY
    }
    func autoAdjustNavigationBarAplha(aplha: CGFloat) {
        self.navigationController?.navigationBar.setMyBackgroundColorAlpha(aplha)
    }
}

enum ParallaxHeaderViewStyle {
    case Default
    case Thumb
}

class ParallaxHeaderView: UIView {
    
    var subView: UIView
    var contentView: UIView = UIView()
    /// 最大的下拉限度（因为是下拉所以总是为负数），超过(小于)这个值，下拉将不会有效果
    var maxOffsetY: CGFloat
    /// 是否需要自动调节导航栏的透明度
    var autoAdjustAplha: Bool = true
    
    weak var delegate: ParallaxHeaderViewDelegate!
    
    
    
    /// 模糊效果的view
    private var blurView: UIVisualEffectView?
    private let defaultBlurViewAlpha: CGFloat = 0.5
    private let style: ParallaxHeaderViewStyle
    
    private let originY:CGFloat = -64
    
     // MARK: - 初始化方法
    init(style: ParallaxHeaderViewStyle,subView: UIView, headerViewSize: CGSize, maxOffsetY: CGFloat, delegate: ParallaxHeaderViewDelegate) {
        
        self.subView = subView
        self.maxOffsetY = maxOffsetY < 0 ? maxOffsetY : -maxOffsetY
        self.delegate = delegate
        self.style = style
        
        super.init(frame: CGRectMake(0, 0, headerViewSize.width, headerViewSize.height))
        //这里是自动布局的设置，大概意思就是subView与它的superView拥有一样的frame
        subView.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth, .FlexibleHeight]
        self.clipsToBounds = false;  //必须得设置成false
        self.contentView.frame = self.bounds
        self.contentView.addSubview(subView)
        self.contentView.clipsToBounds = true
        self.addSubview(contentView)
        
        self.setupStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStyle() {
        switch style {
        case .Default:
            self.autoAdjustAplha = true
        case .Thumb:
            self.autoAdjustAplha = false
            let blurEffect = UIBlurEffect(style: .Light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.alpha = defaultBlurViewAlpha
            blurView.frame = self.subView.frame
            blurView.autoresizingMask = self.subView.autoresizingMask
            
            self.blurView = blurView
            self.contentView.addSubview(blurView)
        }
        
    }
    
     // MARK: - 其他方法
    func layoutHeaderViewWhenScroll(offset: CGPoint) {

        let delta:CGFloat = offset.y

        if delta < maxOffsetY {
            self.delegate.LockScorllView(maxOffsetY)
            
        }else if delta < 0{
            
            var rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)

            rect.origin.y += delta ;
            rect.size.height -= delta;
            self.contentView.frame = rect;
        }
        
        switch style {
        case .Default:
            self.layoutDefaultViewWhenScroll(delta)
            
        case .Thumb:
            self.layoutThumbViewWhenScroll(delta)
        }
        
        if self.autoAdjustAplha {
            let alpha = CGFloat((-originY + delta) / (self.frame.size.height))
            self.delegate.autoAdjustNavigationBarAplha(alpha)
        }
    }

    private func layoutDefaultViewWhenScroll(delta: CGFloat) {
        // do nothing
    }
    
    private func layoutThumbViewWhenScroll(delta: CGFloat) {
        
        if delta > 0 {
            self.contentView.frame.origin.y = delta
        }
        
        if let blurView = self.blurView where delta < 0{
            blurView.alpha = defaultBlurViewAlpha - CGFloat(delta / maxOffsetY)  < 0 ? 0 : defaultBlurViewAlpha - CGFloat(delta / maxOffsetY)
        }
    }

}

