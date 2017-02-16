//
//  JPLoopView.m
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "JPLoopView.h"
#import "JPLoopViewLayout.h"
#import "JPLoopViewCell.h"

NSString *const JPCollectionViewId = @"JPCollectionViewId";
NSInteger const allCount = 200000;

#define scrollTime  5

@interface JPLoopView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation JPLoopView
{
    NSArray <NSString *>    *_urls;
    UICollectionView        *_collectionView;
    UIPageControl           *_pageControl;
    CGRect                  _collectionViewFrame;
    CGRect                  _pageControlFrame;
    NSInteger               _timeCount;//计时
    NSTimer                 *_timer;
    BOOL                    _isDraging;//是否正在滚动
    NSInteger               _viewIndex;//当前是滚动到那个cell
    BOOL                    _isScroll;//为了判断是否滚动
    BOOL                    _autoScroll;//是否自动滚动
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.frame = frame;
    }
    return self;
}

- (void)jp_reloadData{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }

    _urls = [self.dataSource loopViewUrls:self];
    
    if ([self.dataSource respondsToSelector:@selector(scrollViewFrame:)]) {
        _collectionViewFrame = [self.dataSource scrollViewFrame:self];
    }else{
        _collectionViewFrame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    }
    _collectionView = [[UICollectionView alloc]initWithFrame:_collectionViewFrame collectionViewLayout:[[JPLoopViewLayout alloc]init]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[JPLoopViewCell class] forCellWithReuseIdentifier:JPCollectionViewId];
    [self addSubview:_collectionView];
    
    if ([self.dataSource respondsToSelector:@selector(pageControlFrame:)]) {
        _pageControlFrame = [self.dataSource pageControlFrame:self];
    }else{
        _pageControlFrame = CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20);
    }
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    _pageControl.numberOfPages = _urls.count;
    _pageControl.frame = _pageControlFrame;
    if ([self.dataSource respondsToSelector:@selector(hiddenPageControl:)]) {
        _pageControl.hidden = [self.dataSource hiddenPageControl:self];
    }
    [self addSubview:_pageControl];
    
    _autoScroll = YES;
    if ([self.dataSource respondsToSelector:@selector(scrollImage:)]) {
        _autoScroll = [self.dataSource scrollImage:self];
    }
    if (_autoScroll) {
        [self addTimeUpDate];
    }
    
    // 等到主线程数据源方法执行完毕才会执行 异步的滚动方法
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_urls.count) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count*allCount/2 inSection:0];
            _viewIndex = _urls.count*allCount/2;
            [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
    });
}

//将要在父View上显示时 要刷新数据
- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [self jp_reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _urls.count*allCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JPLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JPCollectionViewId forIndexPath:indexPath];
    cell.url = _urls[indexPath.item % _urls.count];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    NSInteger allCellCount = [_collectionView numberOfItemsInSection:0];
    
    //实现无线滚动
    if (index == 0 || index == allCellCount - 1) {
//        NSLog(@"%zd",index);
        
        if (index == 0) {
            index = allCellCount/2;
        }else{
            index = allCellCount/2-1;
        }
    }
    _collectionView.contentOffset = CGPointMake(index*scrollView.bounds.size.width, 0);
    _pageControl.currentPage = index % _urls.count;
    _viewIndex = index;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(didSelectItem:index:)]) {
        [self.delegate didSelectItem:self index:indexPath.item % _urls.count];
    }
}

//时间控制
- (void)addTimeUpDate{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantPast]];
    
}
- (void)update{
    
    _timeCount++;
//    NSLog(@"count  %zd",_timeCount);
    if (_timeCount % scrollTime != 0){
        return;
    }else{
//        NSLog(@"%zd   %zd",_timeCount,_viewIndex);
        _viewIndex++;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_viewIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    _viewIndex = scrollView.contentOffset.x/self.bounds.size.width;
    _pageControl.currentPage = _viewIndex % _urls.count;
}


@end
