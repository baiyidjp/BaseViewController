//
//  IMapView.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

//地图的统一的协议
@protocol IMapView <NSObject>

//在协议中需要定义统一的标准

/**
 初始化view

 @param frame 指定view的大小
 @return view
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 必须是UIView的子类

 @return View
 */
- (UIView *)getView;

@end
