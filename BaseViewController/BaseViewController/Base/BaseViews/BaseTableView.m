//
//  BaseTableView.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/28.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()


@end

@implementation BaseTableView

+ (BaseTableView *)BaseTableView {
    
    return [[self alloc] initWithFrame:CGRectMake(0,NavHeight,KScreenWidth,KScreenHeight-NavHeight-TabBarHeight) Style:UITableViewStylePlain Refresh:YES];
}

+ (BaseTableView *)BaseTableViewWithRefresh:(BOOL)isRefresh {
    
    return [[self alloc] initWithFrame:CGRectMake(0,NavHeight,KScreenWidth,KScreenHeight-NavHeight-TabBarHeight) Style:UITableViewStylePlain Refresh:isRefresh];
}

+ (BaseTableView *)BaseTableViewWithFrame:(CGRect)frame {
    
    return [[self alloc] initWithFrame:frame Style:UITableViewStylePlain Refresh:YES];
}

+ (BaseTableView *)BaseTableViewWithFrame:(CGRect)frame Style:(UITableViewStyle)style {
    
    return [[self alloc] initWithFrame:frame Style:style Refresh:YES];
}

+ (BaseTableView *)BaseTableViewWithFrame:(CGRect)frame Style:(UITableViewStyle)style Refresh:(BOOL)isRefresh {
    
    return [[self alloc] initWithFrame:frame Style:style Refresh:isRefresh];
}

- (instancetype)initWithFrame:(CGRect)frame Style:(UITableViewStyle)style Refresh:(BOOL)isRefresh {
    

    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.frame = frame;
        if (isRefresh) {
            [self setRefresh];
        }
    }
    return self;
}



- (void)setRefresh {
    
    //下拉控件
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(p_RefreshGetNewData)];
    //上拉控件
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(p_RefreshGetMoreData)];
    //隐藏上拉控件 解决加载时出现小尾巴
    self.mj_footer.hidden = YES;
    //隐藏上次刷新的时间
//    self.mj_header.lastUpdatedTimeLabel.hidden = YES;
}

- (void)stopRefresh {
    
    [self p_StopRefreshWithMoreData:YES];
}

- (void)stopRefreshWithNoMoreData {
    
    [self p_StopRefreshWithMoreData:NO];
}

- (void)p_StopRefreshWithMoreData:(BOOL)isMOreData {
    
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    
    if (self.mj_footer.isRefreshing) {
        
        if (isMOreData) {
            [self.mj_footer endRefreshing];
        }else {
            [self.mj_footer endRefreshingWithNoMoreData];
        }
    }

}

- (void)p_RefreshGetNewData {
    
    if ([self.baseTableViewDelegate respondsToSelector:@selector(tableViewRefreshNewData)]) {
        [self.baseTableViewDelegate tableViewRefreshNewData];
    }
}

- (void)p_RefreshGetMoreData {
    
    if ([self.baseTableViewDelegate respondsToSelector:@selector(tableViewRefreshMoreData)]) {
        [self.baseTableViewDelegate tableViewRefreshMoreData];
    }
}


@end
