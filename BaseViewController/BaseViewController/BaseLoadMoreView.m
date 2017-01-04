//
//  BaseLoadMoreView.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaseLoadMoreView.h"

@interface BaseLoadMoreView ()

/** 菊花 */
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
/** 提示文本 */
@property (nonatomic, strong) UILabel *tipsLabel;
/** scroll */
@property(nonatomic,strong) UIScrollView *scrollView;

@end

@implementation BaseLoadMoreView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:_activityView];
        
        _tipsLabel = [[UILabel alloc] initWithFrame:frame];
        _tipsLabel.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        _tipsLabel.text = @"加载更多";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor lightGrayColor];
        _tipsLabel.font = [UIFont systemFontOfSize:14.0];;
        [self addSubview:_tipsLabel];
    }
    return self;
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
    
    if (self.state == LoadMoreState_NoData) {
        return;
    }
    
    CGFloat currentOffsetY = self.scrollView.contentOffset.y;
    //计算上拉 临界点
    CGFloat scroll = currentOffsetY + self.scrollView.frame.size.height - self.scrollView.contentSize.height;
    //判断临界点
    if (self.scrollView.isDragging) {
        
        if (scroll > 44 && self.state == LoadMoreState_Normal) {
            //如果拉伸超过临界点 并且状态是普通 --> 将状态改为pulling
            self.state = LoadMoreState_Pulling;
        } else if (scroll < 44 && self.state == LoadMoreState_Pulling) {
            //如果拉伸低于临界点 并且状态是pulling --> 将状态改为normal
            self.state = LoadMoreState_Normal;
        }
        
    }else {
        //松手
        if (self.state == LoadMoreState_Pulling) {
            //开始刷新
            [self startAnimation];
            if (self.loadMoreDataBlock) {
                self.loadMoreDataBlock();
            }
        }
    }
}



- (void)setState:(LoadMoreState)state {
    
    _state = state;
    switch (state) {
        case LoadMoreState_Normal:
            _tipsLabel.hidden = NO;
            _tipsLabel.text = @"上拉加载";
            _activityView.hidden = YES;
            [_activityView stopAnimating];

            break;
        case LoadMoreState_Pulling:
            _tipsLabel.hidden = NO;
            _tipsLabel.text = @"释放加载";
            _activityView.hidden = YES;
            [_activityView stopAnimating];

            break;
        case LoadMoreState_Refreshing:
            _tipsLabel.hidden = YES;
            _activityView.hidden = NO;
            [_activityView startAnimating];

            break;
        case LoadMoreState_NoData:
            _tipsLabel.hidden = NO;
            _tipsLabel.text = @"没有更多数据";
            _activityView.hidden = YES;
            [_activityView stopAnimating];

            break;
        }
}

- (void)startAnimation
{
    //如果正在刷新 直接return
    if (self.state == LoadMoreState_Refreshing) {
        return;
    }
    //改变刷新状态
    self.state = LoadMoreState_Refreshing;
}

- (void)stopAnimation
{
    //如果不正在刷新 直接return
    if (self.state != LoadMoreState_Refreshing) {
        return;
    }
    //改变刷新状态
    self.state = LoadMoreState_Normal;
}

@end
