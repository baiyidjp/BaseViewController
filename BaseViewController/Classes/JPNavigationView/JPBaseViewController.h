//
//  JPBaseViewController.h
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPNavigationBar.h"

@interface JPBaseViewController : UIViewController

/** 控制共用的NavigationBar 可直接Hidden隐藏 */
@property(nonatomic,strong) JPNavigationBar *jp_NavigationBar;
/** NavigationBar 上的 NavigationItem 导航条目 接收左右的item */
@property(nonatomic,strong) UINavigationItem *jp_NavigationItem;
/** 导航条的颜色 */
@property(nonatomic,strong) UIColor *jp_BarTintColor;
/** 导航大标题的颜色 */
@property(nonatomic,strong) UIColor *jp_BarTitleTextColor;
/** 导航标题的字号 */
@property(nonatomic,strong) UIFont *jp_BarTitleFont;

@end
