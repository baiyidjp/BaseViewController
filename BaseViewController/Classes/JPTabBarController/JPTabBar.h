//
//  JPTabBar.h
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPTabBar : UITabBar

@property (nonatomic,copy) void(^customBtnClick)(UIButton *customBtn);

/**
 自定义UITabBar

 @param frame 布局
 @param isShowCustom 是否展示中间的不规则按钮
 @return tabbar
 */
- (instancetype)initWithFrame:(CGRect)frame ShowCustom:(BOOL)isShowCustom;

@end
