//
//  JPRefreshTableView.m
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/16.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPRefreshTableView.h"
#import "JPRefreshPlaceHolderView.h"
#import <objc/runtime.h>

const char *placeHolderViewKey = "placeHolderViewKey";

@implementation JPRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style hiddenRefresh:(JPHiddenRefresh)hiddenRefresh {
    
    return [self initWithFrame:frame style:style hiddenRefresh:hiddenRefresh placeHolderView:nil];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style placeHolderView:(UIView *)placeHolderView {
    
    return [self initWithFrame:frame style:style hiddenRefresh:JPHiddenRefresh_None placeHolderView:placeHolderView];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style hiddenRefresh:(JPHiddenRefresh)hiddenRefresh placeHolderView:(UIView *)placeHolderView {
    
    self.hiddenRefresh = hiddenRefresh;
    self.placeHolderView = placeHolderView;
    return [self initWithFrame:frame style:style];
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self p_Setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self p_Setup];
    }
    return self;
}

#pragma mark -设置
- (void)p_Setup {
    
    self.estimatedRowHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = refreshHeader;

    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    self.mj_footer = refreshFooter;
    
    [self setHiddenRefresh];
}


- (void)setHiddenRefresh {
    
    BOOL isHiddenHeader = NO;
    BOOL isHiddenFooter = NO;
    
    if (self.hiddenRefresh == JPHiddenRefresh_All) {
        isHiddenFooter = YES;
        isHiddenHeader = YES;
    }else if (self.hiddenRefresh == JPHiddenRefresh_Header) {
        isHiddenHeader = YES;
    }else if (self.hiddenRefresh == JPHiddenRefresh_Footer) {
        isHiddenFooter = YES;
    }
    
    if (isHiddenHeader) {
        [self.mj_header removeFromSuperview];
    }
    if (isHiddenFooter) {
        [self.mj_footer removeFromSuperview];
    }

}

#pragma mark -下拉/上拉
- (void)refreshHeader {
    
    if ([self.refreshDelegate respondsToSelector:@selector(tableView:refreshType:)]) {
        [self.refreshDelegate tableView:self refreshType:JPRefreshType_Header];
    }
}

- (void)refreshFooter {
    
    if ([self.refreshDelegate respondsToSelector:@selector(tableView:refreshType:)]) {
        [self.refreshDelegate tableView:self refreshType:JPRefreshType_Footer];
    }
    
}

- (void)jp_reloadData {
    
    [self reloadData];
    [self p_CheckDataSource];
}

- (void)jp_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self reloadSections:sections withRowAnimation:animation];
    [self p_CheckDataSource];
}

- (void)jp_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self p_CheckDataSource];
}

- (void)jp_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self p_CheckDataSource];
}

- (void)jp_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self p_CheckDataSource];
}

- (UIView *)placeHolderView {
    
    return objc_getAssociatedObject(self, placeHolderViewKey);
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    
    objc_setAssociatedObject(self, placeHolderViewKey, placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -监测是否为空数据源
- (void)p_CheckDataSource {
    
    BOOL isNoData = YES;
    
    id<UITableViewDataSource> source = self.dataSource;
    NSInteger sections = 1;
    if ([source respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [source numberOfSectionsInTableView:self];
    }
    for (NSInteger i = 0; i < sections ; i++) {
        NSInteger rows = [source tableView:self numberOfRowsInSection:i];
        if (rows) {
            isNoData = NO;
        }
    }
    //互斥的存在
    if (!isNoData != !self.placeHolderShowView) {
        
        if (isNoData) {
            
            if (!self.placeHolderShowView) {
                self.placeHolderShowView = self.placeHolderView;
            }
            self.placeHolderShowView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            [self addSubview:self.placeHolderShowView];
        }else {
            [self.placeHolderShowView removeFromSuperview];
            self.placeHolderShowView = nil;
        }
    }else if (isNoData) {
        //永远保证占位View在最上层
        [self.placeHolderShowView removeFromSuperview];
        self.placeHolderShowView = self.placeHolderView;
        [self addSubview:self.placeHolderShowView];
    }
}

- (void)jp_tableViewHeaderBeginRefreshing {
    
    [self.mj_header beginRefreshing];
}

- (void)jp_tableViewHeaderEndRefreshing {
    
    if ([self.mj_header isRefreshing]) {
        
        [self.mj_header endRefreshing];
    }
}

- (void)jp_tableViewFooterEndRefreshingWithNoMoreData:(BOOL)isNoMoreData {
    
    
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
    if (isNoMoreData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.mj_footer setState:MJRefreshStateIdle];
    }
}
- (void)setIsHiddenRefreshHeader:(BOOL)isHiddenRefreshHeader {
    
    _isHiddenRefreshHeader = isHiddenRefreshHeader;
    
    self.mj_header.hidden = isHiddenRefreshHeader;
}

- (void)setIsHiddenRefreshFooter:(BOOL)isHiddenRefreshFooter {
    
    _isHiddenRefreshFooter = isHiddenRefreshFooter;
    
    self.mj_footer.hidden = isHiddenRefreshFooter;
}

@end
