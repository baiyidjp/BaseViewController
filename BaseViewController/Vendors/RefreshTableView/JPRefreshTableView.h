//
//  JPRefreshTableView.h
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/16.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPRefreshPlaceHolderView.h"
#import "MJRefresh.h"

//刷新的状态 上拉/下拉
typedef NS_ENUM(NSInteger, JPRefreshType) {
    JPRefreshType_None,
    JPRefreshType_Header,//头部
    JPRefreshType_Footer//底部
};

//需要隐藏的刷新状态
typedef NS_ENUM(NSInteger, JPHiddenRefresh) {
    JPHiddenRefresh_None,
    JPHiddenRefresh_Header,//头部
    JPHiddenRefresh_Footer,//底部
    JPHiddenRefresh_All//头部加底部
};

@class JPRefreshTableView;
@protocol JPRefreshTableViewDelegate <NSObject>

@optional
/**
 JPRefreshTableViewDelegate
 
 @param tablView 带刷新控件的tableView
 @param refreshType 刷新回调的状态
 */
- (void)tableView:(JPRefreshTableView *)tablView refreshType:(JPRefreshType)refreshType;

@end

/**
 带MJ刷新控件的tableView 适用于代码创建和XIB创建
 */
@interface JPRefreshTableView : UITableView

/** delegate */
@property(nonatomic,weak) id<JPRefreshTableViewDelegate> refreshDelegate;

/**
 创建tableView()

 @param frame 布局
 @param style 样式
 @param hiddenRefresh 是否隐藏上拉/下拉刷新
 @return tableView
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style hiddenRefresh:(JPHiddenRefresh)hiddenRefresh;

/**
 创建tableView(占位图)
 
 @param frame 布局
 @param style 样式
 @param placeHolderView 占位图
 @return tableView
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style placeHolderView:(UIView *)placeHolderView;

/**
 创建tableView(可设置隐藏刷新头/占位图)

 @param frame 布局
 @param style 样式
 @param hiddenRefresh 是否隐藏刷新头
 @param placeHolderView 占位图
 @return tableView
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style hiddenRefresh:(JPHiddenRefresh)hiddenRefresh placeHolderView:(UIView *)placeHolderView;

/** 记录是否隐藏上拉/下拉刷新 */
@property(nonatomic,assign) JPHiddenRefresh hiddenRefresh;
/** PlaceHolderView */
@property(nonatomic,strong) UIView *placeHolderView;
@property(nonatomic,strong) UIView *placeHolderShowView;
/** 隐藏头部 */
@property(nonatomic,assign) BOOL isHiddenRefreshHeader;
/** 隐藏底部 */
@property(nonatomic,assign) BOOL isHiddenRefreshFooter;


/**
 无数据加载占位图必须使用这个刷新
 */
- (void)jp_reloadData;

- (void)jp_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

- (void)jp_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

- (void)jp_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

- (void)jp_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

/** 开始下拉刷新 */
- (void)jp_tableViewHeaderBeginRefreshing;

/** 结束下拉刷新 */
- (void)jp_tableViewHeaderEndRefreshing;

/**
 结束上拉刷新

 @param isNoMoreData 是否提示加载完毕
 */
- (void)jp_tableViewFooterEndRefreshingWithNoMoreData:(BOOL)isNoMoreData;

@end
