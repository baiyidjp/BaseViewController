//
//  BaseViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/3.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+JP_Frame.h"
#import "UIColor+JP_Color.h"
#import "BaseLoadMoreView.h"
#import "JPRefreshControl.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    //取消缩进
    if (@available(iOS 11.0, *)) {
        self.baseTableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //设置导航条
    [self setupNavigationBar];

}


//状态栏的背景色
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

//懒加载
- (BaseNavigationBar *)baseNavigationBar{
    
    if (!_baseNavigationBar) {
        
        _baseNavigationBar =  [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, NAVIGATION_BAR_HEIGHT)];
    }
    return _baseNavigationBar;
}

- (UINavigationItem *)baseNavigationItem{
    
    if (!_baseNavigationItem) {
        
        _baseNavigationItem = [[UINavigationItem alloc] init];
    }
    return _baseNavigationItem;
}

//重写系统设置title的setter
- (void)setTitle:(NSString *)title {
    //正常创建控制器是先执行[alloc init] 后执行这句 在执行时在给予赋值
    self.baseNavigationItem.title = title;
}
/** 设置导航栏 */
- (void)setupNavigationBar {
    
    [self.view addSubview:self.baseNavigationBar];

    //将导航条目 添加到导航条
    self.baseNavigationBar.items = @[self.baseNavigationItem];
    //导航条的渲染颜色
    self.baseNavigationBar.barTintColor = [UIColor jp_colorWithHexString:@"F6F6F6"];
    //设置 bar 的标题字体颜色
    self.baseNavigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor purpleColor]};
    //设置系统的UIBarbuttonItem的字体颜色
    self.baseNavigationBar.tintColor = [UIColor purpleColor];

}

- (void)setupTableViewWithFrame:(CGRect)frame {

    self.baseTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view insertSubview:self.baseTableView belowSubview:self.baseNavigationBar];
    self.baseTableView.dataSource = self;
    self.baseTableView.delegate = self;
    self.baseTableView.estimatedRowHeight = 0;
    self.baseTableView.estimatedSectionFooterHeight = 0;
    self.baseTableView.estimatedSectionHeaderHeight = 0;

    //下拉刷新
    self.refreshControl = [[JPRefreshControl alloc] init];
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.baseTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(loadData1) forControlEvents:UIControlEventValueChanged];
    
    //上拉刷新
    self.loadMoreView = [[BaseLoadMoreView alloc]initWithFrame:CGRectMake(0, 0, self.baseTableView.frame.size.width, 44)];
    self.baseTableView.tableFooterView = self.loadMoreView;
    //加载更多block回掉
    __weak typeof(self) weakSelf = self;
    self.loadMoreView.loadMoreDataBlock = ^() {
        [weakSelf loadMoreData];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[UITableViewCell alloc] init];
}


//下拉调用数据
- (void)loadData1 {
    
//    if (self.refreshControl.isRefreshing) {
//        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中"];
        [self loadNewData];
//    }
}

- (void)loadNewData {
    
    [self.refreshControl endRefreshing];
}

- (void)loadNewEndRefresh {
    
    [self.refreshControl endRefreshing];
}

- (void)loadMoreData {
    
    [self.loadMoreView stopAnimation];
}

- (void)loadMoreEndRefresh {
    
    [self.loadMoreView stopAnimation];
}

- (void)noMoreData {
    
    [self.loadMoreView setState:LoadMoreState_NoData];
}


@end
