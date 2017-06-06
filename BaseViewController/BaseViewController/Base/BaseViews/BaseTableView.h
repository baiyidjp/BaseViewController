//
//  BaseTableView.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/28.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@protocol BaseTableViewDelegate <NSObject>

/**
 下拉刷新的代理方法 配合isRefresh为Yes时使用
 */
- (void)tableViewRefreshNewData;

/**
 上拉刷新的代理方法 配合isRefresh为Yes时使用
 */
- (void)tableViewRefreshMoreData;

@end

@interface BaseTableView : UITableView

@property(nonatomic,weak)id<BaseTableViewDelegate> baseTableViewDelegate;

@property(nonatomic,strong) UIViewController *superController;


/**
 默认创建一个tableView 带刷新控件 默认的frame

 @return tableView
 */
+ (BaseTableView *)BaseTableView;

/**
 创建一个tableView 可选择是否带刷新控件

 @param isRefresh 是否带刷新控件
 @return tableView
 */
+ (BaseTableView *)BaseTableViewWithRefresh:(BOOL)isRefresh;

/**
 创建一个tableView 自定义frame

 @param frame 视图的frame
 @return tableView
 */
+ (BaseTableView *)BaseTableViewWithFrame:(CGRect)frame;

/**
 创建一个tableView 自定义frame和style

 @param frame 视图的frame
 @param style 视图的类型
 @return tableView
 */
+ (BaseTableView *)BaseTableViewWithFrame:(CGRect)frame Style:(UITableViewStyle)style;

/**
 创建一个tableView

 @param frame 视图的位置
 @param style 视图的类型
 @param isRefresh 是否带刷新控件
 @return 返回tableView
 */
+ (BaseTableView *)BaseTableViewWithFrame:(CGRect)frame Style:(UITableViewStyle)style Refresh:(BOOL)isRefresh;


/**
 停止下拉或者上拉刷新
 */
- (void)stopRefresh;

/**
 停止上拉刷新 并提示数据已经加载到最后
 */
- (void)stopRefreshWithNoMoreData;
@end
