//
//  JPTabBar.m
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "JPTabBar.h"

@interface JPTabBar()
/** 中间的不固定按钮 */
@property (nonatomic, strong) UIButton *customButton;
/** 是否显示中间不固定按钮 */
@property(nonatomic,assign) BOOL isShowCustom;
/** 所有UIBarButton集合 */
@property(nonatomic,strong) NSMutableArray *tabBarBtns;
@end

@implementation JPTabBar

- (instancetype)initWithFrame:(CGRect)frame ShowCustom:(BOOL)isShowCustom {
    
    self = [super initWithFrame:frame];
    if (self) {
        if (isShowCustom) {
            
            [self p_SetBigButton];
        }
        self.isShowCustom = isShowCustom;
    }
    return self;
    
    
}

- (UIButton *)customButton{
    
    if (!_customButton) {
        
        _customButton = [[UIButton alloc] init];
        [_customButton setBackgroundColor:[UIColor greenColor]];
        [_customButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [_customButton setTitle:@"董" forState:UIControlStateNormal];
        
    }
    return _customButton;
}

- (NSMutableArray *)tabBarBtns{
    
    if (!_tabBarBtns) {
        
        _tabBarBtns = [NSMutableArray array];
    }
    return _tabBarBtns;
}

- (void)p_SetBigButton {
    
    [self addSubview:self.customButton];
    
    //给按钮添加一个点击事件
    [_customButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.tabBarBtns removeAllObjects];
    //调整uitabbarButton的大小和位置
    for (int i = 0;i < self.subviews.count;i++) {
        
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            //加入数组中 以便在点击时判断
            [self.tabBarBtns addObject:view];
        }
    }
    
    //调整自定义按钮的位置
    CGFloat scale = self.isShowCustom ? self.tabBarBtns.count+1 : self.tabBarBtns.count;
    CGFloat tabbarBtnW = self.jp_w*1.0/scale;
    
    _customButton.frame = CGRectMake(self.tabBarBtns.count/2*tabbarBtnW, -30, tabbarBtnW, self.jp_h+30-HOME_INDICATOR_HEIGHT);
    _customButton.layer.cornerRadius = 5;
    
    for (NSInteger i = 0; i < self.tabBarBtns.count; i++) {
        
        UIView *view = self.tabBarBtns[i];
        //设置宽度
        view.jp_w = tabbarBtnW;
        //根据当前button的index,去设置其对应的x
        view.jp_x = i * tabbarBtnW;
        
        if ((i == self.tabBarBtns.count/2 || i == self.tabBarBtns.count/2+1) && self.isShowCustom) {
            view.jp_x = (i+1)*tabbarBtnW;
        }
    }
}

- (void)btnClick {
    
    if (self.customBtnClick) {
        self.customBtnClick();
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    BOOL canNotResponseEvent = self.hidden || (self.alpha <= 0.01f) || (self.userInteractionEnabled == NO);
    if (canNotResponseEvent) {
        return nil;
    }
    if (!_customButton && ![self pointInside:point withEvent:event]) {
        return nil;
    }
    if (_customButton) {
        CGRect customButtonFrame = _customButton.frame;
        BOOL isInPlusButtonFrame = CGRectContainsPoint(customButtonFrame, point);
        if (!isInPlusButtonFrame && (point.y < 0) ) {
            return nil;
        }
        if (isInPlusButtonFrame) {
            return _customButton;
        }
    }
    NSArray *tabBarButtons = self.tabBarBtns;
    for (NSUInteger index = 0; index < tabBarButtons.count; index++) {
        UIView *selectedTabBarButton = tabBarButtons[index];
        CGRect selectedTabBarButtonFrame = selectedTabBarButton.frame;
        if (CGRectContainsPoint(selectedTabBarButtonFrame, point)) {
            //设置动画
            [self p_SetAnimation:selectedTabBarButton];
            
            return selectedTabBarButton;
        }
    }
    return nil;
    
}

- (void)p_SetAnimation:(UIView *)selectedTabBarButton {
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[selectedTabBarButton layer] addAnimation:pulse forKey:nil];
}

@end
