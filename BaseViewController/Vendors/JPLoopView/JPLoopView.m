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
#import "JPPageControl.h"
#import "JPTimerManager.h"
#import "JPProxy.h"

NSString *const JPCollectionViewCellID = @"JPCollectionViewCellID";
NSInteger const allCount = 10000;//不能是奇数


@interface JPLoopView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** models */
@property(nonatomic,strong) NSMutableArray *loopDataModels;
/** collectionview */
@property(nonatomic,strong) UICollectionView *collectionView;
/** pagecontrol 分页控件 */
@property(nonatomic,strong) JPPageControl *pageControl;
/** totalItems 要显示的所有item的个数*/
@property(nonatomic,assign) NSInteger totalItemsCount;
/** 当前计时器的名字 */
@property(nonatomic,strong) NSString *timerManageName;

@end

@implementation JPLoopView


- (NSMutableArray *)loopDataModels{
    
    if (!_loopDataModels) {
        
        _loopDataModels = [NSMutableArray array];
    }
    return _loopDataModels;
}

+ (instancetype)loopViewWithFrame:(CGRect)frame {
    
    return [self loopViewWithFrame:frame delegate:nil];
}

+ (instancetype)loopViewWithFrame:(CGRect)frame delegate:(id<JPLoopViewDelegate>)delegate {
    
    return [self loopViewWithFrame:frame delegate:delegate placeholderImage:nil];
}

+ (instancetype)loopViewWithFrame:(CGRect)frame delegate:(id<JPLoopViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage {
    
    JPLoopView *loopView = [[self alloc] initWithFrame:frame];
    loopView.delegate = delegate;
    loopView.placeholderImage = placeholderImage;
    return loopView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        [self p_SetDefaultData];
        [self p_SetUI];
    }
    return self;
}

#pragma mark -设置默认数据
- (void)p_SetDefaultData {
    
    self.pageControlAliment = JPLoopViewPageControlAlimentCenter;
    self.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageIndicatorTintColor = [UIColor orangeColor];
    self.pageIndicatorSpaing = 5;
    self.currentPageIndicatorSize = CGSizeMake(6, 6);
    self.pageIndicatorSize = CGSizeMake(6, 6);
    self.pageControlEnabled = NO;
    self.hidesPageControlWhenSingle = YES;
    self.pageControlLeftOffset = 10;
    self.pageControlRightOffset = 10;
    self.pageControlBottomOffset = 5;
    
    self.titleAliment = JPLoopViewTitleAlimentCenter;
    self.titleFont = [UIFont systemFontOfSize:15];
    self.titleColor = [UIColor whiteColor];
    self.titleLeftOffset = 10;
    self.titleRightOffset = 10;
    self.bgViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.bgViewLeftOffset = 0;
    self.bgViewRightOffset = 0;
    self.bgViewBottomOffset = 0;
    self.bgViewHeight = 44;

    
    self.isAutoScroll = YES;
    self.intervalTime = 2;
    self.infiniteLoop = YES;
}

#pragma mark -设置UI
- (void)p_SetUI {
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:[[JPLoopViewLayout alloc]init]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[JPLoopViewCell class] forCellWithReuseIdentifier:JPCollectionViewCellID];
    [self addSubview:self.collectionView];
}

#pragma mark -设置PageControl
- (void)p_SetPageControl {
    
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
    }
    
    if ((self.loopDataModels.count == 1 && self.hidesPageControlWhenSingle) || !self.loopDataModels.count) {
        return;
    }
    
    JPPageControl *pageControl = [[JPPageControl alloc] init];
    pageControl.numberOfPages = self.loopDataModels.count;
    pageControl.pageIndicatorSpaing = self.pageIndicatorSpaing;
    pageControl.currentPageIndicatorSize = self.currentPageIndicatorSize;
    pageControl.pageIndicatorSize = self.pageIndicatorSize;
    pageControl.pageIndicatorImage = self.pageIndicatorImage;
    pageControl.currentPageIndicatorImage = self.currentPageIndicatorImage;
    pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
    pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    pageControl.userInteractionEnabled = self.pageControlEnabled;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    CGSize pageSize = pageControl.contentSize;
    switch (self.pageControlAliment) {
        case JPLoopViewPageControlAlimentNone:
        {
            pageControl.hidden = YES;
            [pageControl removeFromSuperview];
        }
            break;
        case JPLoopViewPageControlAlimentLeft:
        {
            pageControl.hidden = NO;
            pageControl.frame = CGRectMake(self.pageControlLeftOffset, self.frame.size.height-self.pageControlBottomOffset-pageSize.height, pageSize.width, pageSize.height);
        }
            break;
        case JPLoopViewPageControlAlimentCenter:
        {
            pageControl.hidden = NO;
            pageControl.frame = CGRectMake(self.frame.size.width*0.5-pageSize.width*0.5, self.frame.size.height-self.pageControlBottomOffset-pageSize.height, pageSize.width, pageSize.height);

        }
            break;
        case JPLoopViewPageControlAlimentRight:
        {
            pageControl.hidden = NO;
            pageControl.frame = CGRectMake(self.frame.size.width-self.pageControlRightOffset-pageSize.width, self.frame.size.height-self.pageControlBottomOffset-pageSize.height, pageSize.width, pageSize.height);

        }
            break;
    }
}

#pragma mark - 接收外部传入图片数据
- (void)setLoopImageArray:(NSArray *)loopImageArray {
    
    if (!loopImageArray.count) {
        return;
    }
    
    [self.loopDataModels removeAllObjects];
    
    NSMutableArray *urls = [NSMutableArray new];
    
    [loopImageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString && urlString.length) {
            [urls addObject:urlString];
        }

    }];
    
    if (urls.count) {
        for (NSString *url in urls) {
            JPLoopCellModel *cellModel = [[JPLoopCellModel alloc] init];
            cellModel.imageUrlStr = url;
            cellModel.isShowTitle = NO;
            [self.loopDataModels addObject:cellModel];
        }
        [self setLoopData];
    }
}

- (void)setLoopImageArray:(NSArray *)loopImageArray loopTitleArray:(NSArray *)loopTitleArray {
    
    if (!loopImageArray || !loopImageArray.count || (loopTitleArray && loopTitleArray.count && (loopImageArray.count != loopTitleArray.count))) {
        NSLog(@"imageCount != titleCount");
        return;
    }
    
    [self.loopDataModels removeAllObjects];
    
    NSMutableArray *urls = [NSMutableArray new];
    
    [loopImageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *urlString;
        if ([obj isKindOfClass:[NSString class]]) {
            urlString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *)obj;
            urlString = [url absoluteString];
        }
        if (urlString && urlString.length) {
            [urls addObject:urlString];
        }
        
    }];
    
    if (urls.count) {
        for (NSString *url in urls) {
            JPLoopCellModel *cellModel = [[JPLoopCellModel alloc] init];
            cellModel.imageUrlStr = url;
            cellModel.placeholderImage = self.placeholderImage;
            cellModel.isShowTitle = NO; //不存在文本 强制为NO
            [self.loopDataModels addObject:cellModel];
        }
        if (self.loopDataModels.count && loopTitleArray && loopImageArray.count && (loopTitleArray.count == self.loopDataModels.count)) {
            for (NSInteger i = 0; i < self.loopDataModels.count;i++) {
                JPLoopCellModel *cellModel = self.loopDataModels[i];
                cellModel.isShowTitle = YES;
                cellModel.imageTitleStr = loopTitleArray[i];
                cellModel.titleFont = self.titleFont;
                cellModel.titleColor = self.titleColor;
                cellModel.titleAliment = self.titleAliment;
                cellModel.titleLeftOffset = self.titleLeftOffset;
                cellModel.titleRightOffset = self.titleRightOffset;
                cellModel.bgViewColor = self.bgViewColor;
                cellModel.bgViewHeight = self.bgViewHeight;
                cellModel.bgViewLeftOffset = self.bgViewLeftOffset;
                cellModel.bgViewRightOffset = self.bgViewRightOffset;
                cellModel.bgViewBottomOffset = self.bgViewBottomOffset;
            }
        }
        [self setLoopData];
    }

}

#pragma mark - 设置显示的数据
- (void)setLoopData {
    
    if (!self.loopDataModels.count) {
        return;
    }
    
    self.totalItemsCount = self.infiniteLoop ? self.loopDataModels.count * allCount : self.loopDataModels.count;
    
    if (self.loopDataModels.count != 1) {
        self.collectionView.scrollEnabled = YES;
        if (self.isAutoScroll) {
            [self p_StarTimer];
        }
    } else {
        //一张图片不准滑动了
        self.collectionView.scrollEnabled = NO;
    }

    [self p_SetPageControl];
    [self.collectionView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.loopDataModels.count && self.infiniteLoop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.totalItemsCount/2 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JPLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JPCollectionViewCellID forIndexPath:indexPath];
    JPLoopCellModel *cellModel = self.loopDataModels[indexPath.item % self.loopDataModels.count];
    cell.cellModel = cellModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(didSelectItem:index:)]) {
        [self.delegate didSelectItem:self index:indexPath.item % self.loopDataModels.count];
    }
}

//滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.loopDataModels.count) {
        return;
    }
    NSInteger index = [self p_CurrentIndex];
    self.pageControl.currentPage = index % self.loopDataModels.count;
    
}

//自动轮播 停止的位置
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSInteger index = [self p_CurrentIndex];
    self.pageControl.currentPage = index % self.loopDataModels.count;
}

//手指开始滑动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //如果是无线滚动 结束定时器
    if (self.isAutoScroll) {
        
        [self p_InvalidateTimer];
    }
}

//手指结束滑动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //如果是无线滚动 重启定时器
    if (self.isAutoScroll) {
        
        [self p_StarTimer];
    }

}

//手指滑动 滚动的位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = [self p_CurrentIndex];
    NSInteger allCellCount = [self.collectionView numberOfItemsInSection:0];
    
    //实现无限滚动
    if (index == 0 || index == allCellCount - 1) {
        
        if (self.infiniteLoop) {
            
            if (index == 0) {
                index = allCellCount/2;
            }else{
                index = allCellCount/2-1;
            }
        }
    }
    self.collectionView.contentOffset = CGPointMake(index*scrollView.bounds.size.width, 0);
    self.pageControl.currentPage = index % self.loopDataModels.count;
    
}


#pragma mark - starTimer 开始定时器
- (void)p_StarTimer {
    
    [self p_InvalidateTimer];
    
    self.timerManageName = [JPTimerManager timerBeginWithStartTime:self.intervalTime intervalTime:self.intervalTime repeats:YES async:NO target:[[JPProxy alloc] initWithTarget:self] selector:@selector(p_ScrollLoopView)];
}
- (void)p_ScrollLoopView {
    
    NSInteger currentIndex = [self p_CurrentIndex];
    [self p_LoopViewScrollToIndex:currentIndex+1];
}

//滚动collectionview
- (void)p_LoopViewScrollToIndex:(NSInteger)currentIndex {
    
    if (currentIndex >= self.totalItemsCount) {
        if (self.infiniteLoop) {
            currentIndex = self.totalItemsCount * 0.5;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}


#pragma mark -invalidateTimer 结束定时器
- (void)p_InvalidateTimer {
    
    if (self.timerManageName) {
        [JPTimerManager cancelTask:self.timerManageName];
        self.timerManageName = nil;
    }
}

#pragma mark - 取到当前cell的下标
- (NSInteger)p_CurrentIndex {
    
    CGPoint center = self.collectionView.center;
    center.x += self.collectionView.contentOffset.x;
    center.y = self.collectionView.bounds.size.height/2.0;
    
    NSArray *indexPaths = self.collectionView.indexPathsForVisibleItems;
    
    for (NSIndexPath *indexPath in indexPaths) {
        
        JPLoopViewCell *cell = (JPLoopViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        //检查中心现在何处
        if (CGRectContainsPoint(cell.frame, center)) {
            
            return MAX(0,indexPath.item);
        }
    }
    return 0;
}

- (void)dealloc {
    
    NSLog(@"%s",__func__);
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    if (self.timerManageName && self.timerManageName.length) {
        [self p_InvalidateTimer];
    }
}

@end
