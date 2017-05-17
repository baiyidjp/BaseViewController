//
//  BaseTabBar.h
//  BaseViewController
//
//  Created by Keep丶Dream on 2017/5/17.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBar : UITabBar

@property (nonatomic,copy) void(^customBtnClick)();

@end
