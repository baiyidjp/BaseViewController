//
//  JPRefreshPlaceHolderView.h
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/24.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedCompletion)();

@interface JPRefreshPlaceHolderView : UIView

/**
 基础构造方法

 @return 默认的占位View
 */
- (instancetype)init;

/**
 自定义占位图和文字的构造方法

 @param placeHolderImage 占位图
 @param placeHolderTip 占位文字
 @return 带图文的占位View
 */
- (instancetype)initWithPlaceHolderImage:(UIImage *)placeHolderImage PlaceHolderTip:(NSString *)placeHolderTip;

/**
 自定义占位图和文字并附带点击处理(SEL)的构造方法

 @param placeHolderImage 占位图
 @param placeHolderTip 占位文字
 @param target 默认传self
 @param action 点击占位View需要相应的方法
 @return 占位view
 */
- (instancetype)initWithPlaceHolderImage:(UIImage *)placeHolderImage PlaceHolderTip:(NSString *)placeHolderTip Target:(id)target Action:(SEL)action;

/**
 自定义占位图和文字并附带点击处理(block)的构造方法

 @param placeHolderImage 占位图
 @param placeHolderTip 占位文字
 @param completion 点击的回调
 @return 占位view
 */
- (instancetype)initWithPlaceHolderImage:(UIImage *)placeHolderImage PlaceHolderTip:(NSString *)placeHolderTip completion:(selectedCompletion)completion;

//重置占位图和文字的值

/** 占位图 */
@property(nonatomic,strong) UIImage *placeHolderImage;
/** tips */
@property(nonatomic,strong) NSString *placeHolderTip;

@end
