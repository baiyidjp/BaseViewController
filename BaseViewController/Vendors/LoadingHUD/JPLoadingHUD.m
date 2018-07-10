//
//  JPLoadingHUD.m
//  BaseViewController
//
//  Created by Keep丶Dream on 2017/12/11.
//  Copyright © 2017年 dong. All rights reserved.
//


#import "JPLoadingHUD.h"
#import "UIColor+JP_Color.h"

#define k_Width [UIScreen mainScreen].bounds.size.width
#define k_Height [UIScreen mainScreen].bounds.size.height
static const CGFloat k_BallWH = 10.0f;
static const CGFloat k_BallMoveX = 20.0f;
static const CGFloat k_Duration = 1.0f;

@implementation JPLoadingHUD
{
    UIView *_firstBallView;
    UIView *_secondBallView;
    UIView *_threeBallView;
    UIView *_fourthBallView;
    NSMutableArray *_ballViewArray;
}

+ (JPLoadingHUD *)sharedHUD {
    
    static JPLoadingHUD *sharedHUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHUD = [[[self class] alloc]init];
    });
    return sharedHUD;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = UIScreen.mainScreen.bounds;
        _ballViewArray = [NSMutableArray arrayWithCapacity:4];
        //默认的初始位置 从第一个算起
        CGFloat defaultX = k_Width*0.5 - 2*k_BallWH;
        CGFloat defaultY = k_Height*0.5-k_BallWH*0.5;
        for (NSInteger i = 0; i < 4; i++) {
            UIView *ballView = [[UIView alloc] initWithFrame:CGRectMake(defaultX+i*k_BallWH, defaultY, k_BallWH, k_BallWH)];
            ballView.backgroundColor = RGBRandomColor;
            ballView.layer.cornerRadius = k_BallWH*0.5;
            [self addSubview:ballView];
            [_ballViewArray addObject:ballView];
        }
    }
    return self;
}

+ (void)showLoadingHUD {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        JPLoadingHUD *loadHUD = [JPLoadingHUD sharedHUD];
        if (window != nil) {
            [window addSubview:loadHUD];
            [loadHUD p_StartLoadingAnimation];
        }
    });
}

+ (void)dismissLoadingHUD {
    
    dispatch_async(dispatch_get_main_queue(), ^{

        JPLoadingHUD *loadHUD = [JPLoadingHUD sharedHUD];
        [loadHUD p_StopLoadingAnimation];
        [loadHUD removeFromSuperview];
    });

}

#pragma mark -执行动画
- (void)p_StartLoadingAnimation {
    
    CGPoint firstDefaultPoint = CGPointMake(k_Width*0.5 - 2*k_BallWH+k_BallWH*0.5, k_Height*0.5);
    CGPoint firstMovePoint = CGPointMake(k_Width*0.5 - 2*k_BallWH+k_BallWH*0.5-k_BallMoveX, k_Height*0.5);
    
    UIBezierPath *firstBallPath = [UIBezierPath bezierPath];
    [firstBallPath moveToPoint:firstDefaultPoint];
    [firstBallPath addLineToPoint:firstMovePoint];
    [firstBallPath addLineToPoint:firstDefaultPoint];
    
    CAKeyframeAnimation *animation_0 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_0.path = firstBallPath.CGPath;
    animation_0.removedOnCompletion = YES;
    animation_0.duration = k_Duration*0.5;
    
    CAKeyframeAnimation *animation_01 = [CAKeyframeAnimation animation];
    animation_01.beginTime = k_Duration*0.5;
    
    CAAnimationGroup *groupAnimation_0 = [CAAnimationGroup animation];
    groupAnimation_0.animations = @[animation_0,animation_01];
    groupAnimation_0.duration = k_Duration;
    groupAnimation_0.repeatCount = INFINITY;
    groupAnimation_0.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    UIView *ballView_0 = [_ballViewArray objectAtIndex:0];
    [ballView_0.layer addAnimation:groupAnimation_0 forKey:@"animation_0"];
    
    CGPoint lastDefaultPoint = CGPointMake(k_Width*0.5 + k_BallWH+k_BallWH*0.5, k_Height*0.5);
    CGPoint lastMovePoint = CGPointMake(k_Width*0.5 + k_BallWH+k_BallWH*0.5+k_BallMoveX, k_Height*0.5);
    
    CAKeyframeAnimation *animation_31 = [CAKeyframeAnimation animation];

    UIBezierPath *lastBallPath = [UIBezierPath bezierPath];
    [lastBallPath moveToPoint:lastDefaultPoint];
    [lastBallPath addLineToPoint:lastMovePoint];
    [lastBallPath addLineToPoint:lastDefaultPoint];
    
    CAKeyframeAnimation *animation_3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation_3.path = lastBallPath.CGPath;
    animation_3.removedOnCompletion = YES;
    animation_3.duration = k_Duration*0.5;
    animation_3.beginTime = k_Duration*0.5;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation_31,animation_3];
    groupAnimation.repeatCount = INFINITY;
    groupAnimation.duration = k_Duration;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    UIView *ballView_3 = [_ballViewArray objectAtIndex:3];
    [ballView_3.layer addAnimation:groupAnimation forKey:@"animation_3"];
}

#pragma mark -停止动画
- (void)p_StopLoadingAnimation {
    
    UIView *ballView_0 = [_ballViewArray objectAtIndex:0];
    [ballView_0.layer removeAllAnimations];
    UIView *ballView_3 = [_ballViewArray objectAtIndex:3];
    [ballView_3.layer removeAllAnimations];
}


@end
