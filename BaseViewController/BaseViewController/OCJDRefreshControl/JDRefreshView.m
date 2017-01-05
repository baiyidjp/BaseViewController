//
//  JPRefreshView.m
//  OCJDRefreshControl
//
//  Created by tztddong on 2016/12/26.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "JDRefreshView.h"

@interface JDRefreshView ()

/** 底部盒子视图 */
@property(nonatomic,strong)UIImageView *tipBoxIcon;
/** 小人视图 */
@property(nonatomic,strong)UIImageView *tipPersonIcon;
/** 提示Label */
@property(nonatomic,strong)UILabel *tipLable;
/** '购物更健康' */
@property(nonatomic,strong)UILabel *staticLable;
/** 刷新视图 */
@property(nonatomic,strong)UIImageView *refreshImage;

@end

@implementation JDRefreshView

- (UIImageView *)tipBoxIcon{
    
    if (!_tipBoxIcon) {
        _tipBoxIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"box"]];
    }
    return _tipBoxIcon;
}

- (UIImageView *)tipPersonIcon{
    
    if (!_tipPersonIcon) {
        _tipPersonIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"staticDeliveryStaff"]];
    }
    return _tipPersonIcon;
}

- (UILabel *)tipLable{
    
    if (!_tipLable) {
        _tipLable = [[UILabel alloc] init];
        _tipLable.font = [UIFont systemFontOfSize:14];
        _tipLable.textColor = [UIColor darkGrayColor];
        _tipLable.text = @"下拉更新...";
    }
    return _tipLable;
}

- (UILabel *)staticLable{
    
    if (!_staticLable) {
        _staticLable = [[UILabel alloc] init];
        _staticLable.font = [UIFont systemFontOfSize:14];
        _staticLable.textColor = [UIColor darkGrayColor];
        _staticLable.text = @"购物更健康";
    }
    return _staticLable;
}

- (UIImageView *)refreshImage{
    
    if (!_refreshImage) {
        _refreshImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deliveryStaff"]];
    }
    return _refreshImage;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
    }
    return self;
}

#pragma mark - setUI
- (void)setUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.tipBoxIcon];
    [self addSubview:self.tipLable];
    [self addSubview:self.tipPersonIcon];
    [self addSubview:self.staticLable];
    [self addSubview:self.refreshImage];
    
    //布局
    //小人紧贴底部
    _tipPersonIcon.layer.anchorPoint = CGPointMake(0.5, 1.0);
    _tipPersonIcon.center = CGPointMake(personImageCenterX, viewNormalHeight);
    //盒子中心Y和小人中心Y
    _tipBoxIcon.center = CGPointMake(CGRectGetMaxX(_tipPersonIcon.frame), viewNormalHeight-CGRectGetHeight(_tipPersonIcon.frame)/2.0);
    //初始比例0.1
    _tipPersonIcon.transform = CGAffineTransformMakeScale(0.1, 0.1);
    _tipBoxIcon.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    _refreshImage.layer.anchorPoint = CGPointMake(0.5, 1.0);
    _refreshImage.center = CGPointMake(personImageCenterX, viewNormalHeight);
    _refreshImage.hidden = YES;
    UIImage *imageA = [UIImage imageNamed:@"deliveryStaff1"];
    UIImage *imageB = [UIImage imageNamed:@"deliveryStaff2"];
    UIImage *imageC = [UIImage imageNamed:@"deliveryStaff3"];
    _refreshImage.image = [UIImage animatedImageWithImages:@[imageA,imageB,imageC] duration:0.3];
    
    _staticLable.frame = CGRectMake(CGRectGetMaxX(_tipBoxIcon.frame)+30, 27, 90, 14);
    _tipLable.frame = CGRectMake(CGRectGetMaxX(_tipBoxIcon.frame)+30, 51, 90, 14);
}

- (void)setViewHeight:(CGFloat)viewHeight {
    
    _viewHeight = viewHeight;
    if (viewHeight > viewNormalHeight) {
        _refreshImage.hidden = NO;
        _tipPersonIcon.hidden = YES;
        _tipBoxIcon.hidden = YES;
    }else{
        _refreshImage.hidden = YES;
        _tipPersonIcon.hidden = NO;
        _tipBoxIcon.hidden = NO;
        _tipPersonIcon.transform = CGAffineTransformMakeScale(viewHeight/viewNormalHeight, viewHeight/viewNormalHeight);
        _tipBoxIcon.transform = CGAffineTransformMakeScale(viewHeight/viewNormalHeight, viewHeight/viewNormalHeight);
        if (_refreshState == JPRefreshStateRefreshing) {
            _refreshImage.hidden = NO;
            _tipPersonIcon.hidden = YES;
            _tipBoxIcon.hidden = YES;
        }
    }
}


- (void)setRefreshState:(JPRefreshState)refreshState {
    
    _refreshState = refreshState;
    
    switch (refreshState) {
        case JPRefreshStateNormal:
            _tipLable.text = @"下拉更新...";
            break;
        case JPRefreshStatePulling:
            _tipLable.text = @"松手更新...";
            break;
        case JPRefreshStateRefreshing:
            _tipLable.text = @"更新中...";
            break;
    }
}

@end
