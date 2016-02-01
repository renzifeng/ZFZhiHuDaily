//
//  DetailHeaderView.h
//  WBZhiHuDailyPaper
//
//  Created by 任子丰 on 15/12/23.
//  Copyright © 2015年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeaderView : UIView

+ (DetailHeaderView *)attachObserveToScrollView:(UIScrollView *)scrollView
                                          target:(id)target
                                          action:(SEL)action;

@end

