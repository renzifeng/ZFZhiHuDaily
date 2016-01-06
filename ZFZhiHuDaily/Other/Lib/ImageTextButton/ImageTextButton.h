//
//  ImageTextButton.h
//  ButtonMul
//
//  ImageTextButton is inherited from UIButton, so all the methods of UIButton apply to ImageTextButton
//
//  Created by Jonren on 15/12/29.
//  Copyright © 2015年 Jonren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIButtonTitleWithImageAlignmentUp = 0,  // image is up, title is down
    UIButtonTitleWithImageAlignmentLeft,    // image is left, title is right
    UIButtonTitleWithImageAlignmentDown,    // image is down, title is up
    UIButtonTitleWithImageAlignmentRight    // image is right, title is left
} UIButtonTitleWithImageAlignment;

@interface ImageTextButton : UIButton

@property (nonatomic) CGFloat imgTextDistance;  // distance between image and title, default is 5
@property (nonatomic) UIButtonTitleWithImageAlignment buttonTitleWithImageAlignment;  // need to set a value when used

- (UIButtonTitleWithImageAlignment)buttonTitleWithImageAlignment;
- (void)setButtonTitleWithImageAlignment:(UIButtonTitleWithImageAlignment)buttonTitleWithImageAlignment;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)img title:(NSString *)title;


@end
