//
//  DetailFooterView.h
//  WBZhiHuDailyPaper
//
//  Created by 任子丰 on 15/12/24.
//  Copyright © 2015年 任子丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailFooterView : UIView

+ (DetailFooterView *)attachObserveToScrollView:(UIScrollView *)scrollView
                                         target:(id)target
                                         action:(SEL)action;

@end
