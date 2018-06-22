//
//  BaseNavigationBar.m
//  iPhoneShow
//
//  Created by Keep丶Dream on 2017/10/17.
//  Copyright © 2017年 dhhsMac. All rights reserved.
//

#import "BaseNavigationBar.h"

@implementation BaseNavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //注意导航栏及状态栏高度适配
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), NAVIGATION_BAR_HEIGHT);
    for (UIView *view in self.subviews) {
        if([NSStringFromClass([view class]) containsString:@"Background"]) {
            view.frame = self.bounds;
        }
        else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
            CGRect frame = view.frame;
            frame.origin.y = STATUS_BAR_HEIGHT;
            frame.size.height = self.bounds.size.height - frame.origin.y;
            view.frame = frame;
//            if (systemVersion >=11) {
//                view.layoutMargins = UIEdgeInsetsZero;
//            }

        }
    }
    
    

}


@end
