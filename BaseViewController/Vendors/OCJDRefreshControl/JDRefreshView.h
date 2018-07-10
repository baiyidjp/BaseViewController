//
//  JPRefreshView.h
//  OCJDRefreshControl
//
//  Created by tztddong on 2016/12/26.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

//屏幕的宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
//view的高度
#define viewNormalHeight  84
//临界点
#define refreshOffset 84
//小人的中心X
#define personImageCenterX  ScreenWidth/3.0

/**
 Normal: 普通状态
 Pulling: 下拉到临界点 但是并未松手
 Refreshing: 下拉到临界点 并且已经松手 正在刷新
 */
typedef enum : NSUInteger {
    JPRefreshStateNormal,
    JPRefreshStatePulling,
    JPRefreshStateRefreshing,
} JPRefreshState;

@interface JDRefreshView : UIView

/** 刷新视图的高度 */
@property(nonatomic,assign)CGFloat viewHeight;
/** 刷新状态 */
@property(nonatomic,assign)JPRefreshState refreshState;

@end
