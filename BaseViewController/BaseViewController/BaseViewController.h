//
//  BaseViewController.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/3.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseLoadMoreView;
@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic,strong)UITableView *baseTableView;
/** refreshControl */
@property(nonatomic,strong) UIRefreshControl *refreshControl;
/** 自定义导航栏 */
@property(nonatomic,strong) UINavigationBar *baseNavigationBar;

/** 自定义导航条目 */
@property(nonatomic,strong) UINavigationItem *baseNavigationItem;

/** 加载滚动视图 */
- (void)setupTableViewWithFrame:(CGRect)frame;

/** loadNewData */
- (void)loadNewData;
/** loadNewEndRefresh */
- (void)loadNewEndRefresh;

/** loadMoreView */
@property(nonatomic,strong) BaseLoadMoreView *loadMoreView;
/** loadMoreData */
- (void)loadMoreData;
/** loadMoreEndRefresh */
- (void)loadMoreEndRefresh;
/** noMoreData */
- (void)noMoreData;

@end
