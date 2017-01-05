//
//  JPRefreshControl.m
//  OCJDRefreshControl
//
//  Created by tztddong on 2016/12/26.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "JPRefreshControl.h"
#import "JDRefreshView.h"
#import "JPNormalRefreshView.h"

@interface JPRefreshControl ()

//@property(nonatomic,strong)JDRefreshView *refreshView;

@property(nonatomic,strong)JPNormalRefreshView *refreshView;

@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation JPRefreshControl

//- (JDRefreshView *)refreshView{
//    
//    if (!_refreshView) {
//        _refreshView = [[JDRefreshView alloc] initWithFrame:CGRectZero];
//    }
//    return _refreshView;
//}

- (JPNormalRefreshView *)refreshView{
    
    if (!_refreshView) {
        
        _refreshView = [[JPNormalRefreshView alloc] initWithFrame:CGRectZero];
    }
    return _refreshView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

#pragma mark - setUI
- (void)setupUI{
    
    self.backgroundColor = self.superview.backgroundColor;
    
    [self addSubview:self.refreshView];
}

/**
 将要显示在父视图上 添加KVO监听

 @param newSuperview 父视图
 */
- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
    self.scrollView = (UIScrollView *)newSuperview;
    
    //添加KVO监听 contentOffset
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}

/**
 从父视图移除 移除KVO监听
 */
- (void)removeFromSuperview {
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    [super removeFromSuperview];
}


/**
 KVO监听回调方法
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    //由scrollView的contentOffset.y 加上 scrollView的contentInset.top 取反值 便是刷新View的高度
    CGFloat height = -(self.scrollView.contentOffset.y+self.scrollView.contentInset.top);
    
    //对于height<0
    if (height < 0 ) {
        height = 0;
    }
    
    //设置刷新View的ViewHeight
    self.refreshView.viewHeight = height;
    //设置刷新控件的frame
    self.frame = CGRectMake(0, -height, ScreenWidth, height);
    self.refreshView.frame = CGRectMake(0, height-viewNormalHeight, ScreenWidth, viewNormalHeight);
    
    //判断临界点
    if (self.scrollView.isDragging) {
    
        if (height > refreshOffset && self.refreshView.refreshState == JPRefreshStateNormal) {
            //如果拉伸超过临界点 并且状态是普通 --> 将状态改为pulling
            self.refreshView.refreshState = JPRefreshStatePulling;
        } else if (height < refreshOffset && self.refreshView.refreshState == JPRefreshStatePulling) {
            //如果拉伸低于临界点 并且状态是pulling --> 将状态改为normal
            self.refreshView.refreshState = JPRefreshStateNormal;
        }
        
    }else {
        //松手
        if (self.refreshView.refreshState == JPRefreshStatePulling) {
            //开始刷新
            [self beginRefreshing];
            //发送触发事件
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)beginRefreshing {
    
    //如果正在刷新 直接return
    if (self.refreshView.refreshState == JPRefreshStateRefreshing) {
        return;
    }
    //改变刷新状态
    self.refreshView.refreshState = JPRefreshStateRefreshing;
    //改变scrollView的contentInset 停留刷新
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.top += refreshOffset;
    self.scrollView.contentInset = inset;
}

- (void)endRefreshing {
    
    //如果不是正在刷新 直接return
    if (self.refreshView.refreshState != JPRefreshStateRefreshing) {
        return;
    }
    //改变刷新状态
    self.refreshView.refreshState = JPRefreshStateNormal;
    //改变scrollView的contentInset 停留刷新
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.top -= refreshOffset;
    self.scrollView.contentInset = inset;
}

@end
