//
//  CircleRefreshView.h
//  WBZhiHuDailyPaper
//
//  Created by 任子丰 on 15/12/22.
//  Copyright © 2015年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleRefreshView : UIView

- (void)attachObserveToScrollView:(UIScrollView *)scrollView
                                   target:(id)target
                                   action:(SEL)action;

- (void)endRefreshing;

@end
