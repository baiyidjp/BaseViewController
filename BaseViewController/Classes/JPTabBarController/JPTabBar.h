//
//  JPTabBar.h
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPTabBar : UITabBar

@property (nonatomic,copy) void(^customBtnClick)();

- (instancetype)initWithFrame:(CGRect)frame ShowCustom:(BOOL)isShowCustom;

@end
