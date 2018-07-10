//
//  JPBaseViewController.h
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPBaseViewController : UIViewController

/** 是否隐藏导航栏 */
@property(nonatomic,assign) BOOL isHiddenNavigationBar;
/** 导航条的颜色 */
@property(nonatomic,strong) UIColor *jp_BarTintColor;
/** 导航大标题的颜色 */
@property(nonatomic,strong) UIColor *jp_BarTitleTextColor;
/** 导航标题的字号 */
@property(nonatomic,strong) UIFont *jp_BarTitleFont;

/**
 设置item

 @param item item
 @param isLeft 是否是左边
 */
- (void)jp_SetItem:(UIBarButtonItem *)item Layout:(BOOL)isLeft;

/**
 设置items

 @param items items
 @param isLeft 是否是左边
 */
- (void)jp_SetItems:(NSArray *)items Layout:(BOOL)isLeft;

@end
