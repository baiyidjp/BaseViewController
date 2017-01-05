//
//  JPNormalRefreshView.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPNormalRefreshView.h"

@interface JPNormalRefreshView ()

/** 提示Label */
@property(nonatomic,strong)UILabel *tipLable;
/** 菊花 */
@property(nonatomic,strong) UIActivityIndicatorView *activeView;

@end

@implementation JPNormalRefreshView

- (UILabel *)tipLable{
    
    if (!_tipLable) {
        _tipLable = [[UILabel alloc] init];
        _tipLable.font = [UIFont systemFontOfSize:14];
        _tipLable.textColor = [UIColor darkGrayColor];
        _tipLable.textAlignment = NSTextAlignmentCenter;
        _tipLable.frame = CGRectMake(0, 22, ScreenWidth, 20);
        _tipLable.text = @"下拉更新";
    }
    return _tipLable;
}

- (UIActivityIndicatorView *)activeView{
    
    if (!_activeView) {
        
        _activeView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activeView.frame = CGRectMake(ScreenWidth/2.0-10, 22, 20, 20);
    }
    return _activeView;
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
    
    [self addSubview:self.activeView];
    [self addSubview:self.tipLable];
}


- (void)setRefreshState:(JPNormalRefreshState)refreshState {
    
    _refreshState = refreshState;
    
    switch (refreshState) {
        case JPNormalRefreshStateNormal:
            _tipLable.text = @"下拉加载";
            _tipLable.hidden = NO;
            [_activeView stopAnimating];
            break;
        case JPNormalRefreshStatePulling:
            _tipLable.text = @"释放加载";
            _tipLable.hidden = NO;
            [_activeView stopAnimating];
            break;
        case JPNormalRefreshStateRefreshing:
            _tipLable.hidden = YES;
            [_activeView startAnimating];
            break;
    }
}


@end
