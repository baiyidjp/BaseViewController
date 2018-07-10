//
//  JPNormalRefreshView.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

//屏幕的宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
//view的高度
#define viewNormalHeight  64
//临界点
#define refreshOffset 64

/**
 Normal: 普通状态
 Pulling: 下拉到临界点 但是并未松手
 Refreshing: 下拉到临界点 并且已经松手 正在刷新
 */
typedef enum : NSUInteger {
    JPNormalRefreshStateNormal,
    JPNormalRefreshStatePulling,
    JPNormalRefreshStateRefreshing,
} JPNormalRefreshState;


@interface JPNormalRefreshView : UIView

/** 刷新状态 */
@property(nonatomic,assign)JPNormalRefreshState refreshState;

/** 刷新视图的高度 */
@property(nonatomic,assign)CGFloat viewHeight;

@end
