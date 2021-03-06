//
//  UIPageControl+Night.m
//  UIPageControl+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UIPageControl+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UIPageControl ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKPicker> *pickers;

@end

@implementation UIPageControl (Night)


- (DKColorPicker)dk_pageIndicatorTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_pageIndicatorTintColorPicker));
}

- (void)setDk_pageIndicatorTintColorPicker:(DKColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_pageIndicatorTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.pageIndicatorTintColor = picker();
    [self.pickers setValue:[picker copy] forKey:@"setPageIndicatorTintColor:"];
}

- (DKColorPicker)dk_currentPageIndicatorTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_currentPageIndicatorTintColorPicker));
}

- (void)setDk_currentPageIndicatorTintColorPicker:(DKColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_currentPageIndicatorTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.currentPageIndicatorTintColor = picker();
    [self.pickers setValue:[picker copy] forKey:@"setCurrentPageIndicatorTintColor:"];
}


@end
