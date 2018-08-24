//
//  JPRefreshPlaceHolderView.m
//  JPRefreshTableViewDemo
//
//  Created by Keep丶Dream on 2017/10/24.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPRefreshPlaceHolderView.h"
#import <objc/message.h>

//图片的宽高
static CGFloat kImageW = 140;
static CGFloat kImageH = 103;

#define MsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define MsgTarget(target) (__bridge void *)(target)


@interface JPRefreshPlaceHolderView ()

/** imageV */
@property(nonatomic,strong) UIImageView *imageV;
/** tip */
@property(nonatomic,strong) UILabel *tipLabel;
/** 回调对象 */
@property (weak, nonatomic) id target;
/** 回调方法 */
@property (assign, nonatomic) SEL action;
/** completion */
@property(nonatomic,copy) selectedCompletion completion;

@end

@implementation JPRefreshPlaceHolderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_AddViewsWithImage:nil tip:@""];
    }
    return self;
}

- (instancetype)initWithPlaceHolderImage:(UIImage *)placeHolderImage PlaceHolderTip:(NSString *)placeHolderTip {
    
    self = [super init];
    if (self) {
        [self p_AddViewsWithImage:placeHolderImage tip:placeHolderTip];
    }
    return self;
}

- (instancetype)initWithPlaceHolderImage:(UIImage *)placeHolderImage PlaceHolderTip:(NSString *)placeHolderTip Target:(id)target Action:(SEL)action {
    
    self = [super init];
    if (self) {
        self.target = target;
        self.action = action;
        [self p_AddViewsWithImage:placeHolderImage tip:placeHolderTip];
    }
    return self;

}

- (instancetype)initWithPlaceHolderImage:(UIImage *)placeHolderImage PlaceHolderTip:(NSString *)placeHolderTip completion:(selectedCompletion)completion {
    
    self = [super init];
    if (self) {
        self.completion = completion;
        [self p_AddViewsWithImage:placeHolderImage tip:placeHolderTip];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    CGFloat kWidth = frame.size.width;
    CGFloat kHeight = frame.size.height;
    
    self.imageV.frame = CGRectMake(0, 0, kImageW, kImageH);
    self.imageV.center =CGPointMake(kWidth/2, kHeight/2-10);
    self.tipLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageV.frame),kWidth, 20);
    if (self.placeHolderImage == nil) {
        self.tipLabel.center =CGPointMake(kWidth/2, kHeight/2);
    }

}

#pragma mark -views
- (void)p_AddViewsWithImage:(UIImage *)placeHolderImage tip:(NSString *)placeHolderTip {
    
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    self.placeHolderImage = placeHolderImage;
    self.placeHolderTip = placeHolderTip;

    UIImageView * imageV = [[UIImageView alloc] init];
    imageV.image = placeHolderImage;
    [self addSubview:imageV];
    self.imageV = imageV;
    if (placeHolderImage == nil) {
        imageV.hidden = YES;
    }
    
    UILabel * tipLabel = [[UILabel alloc] init];
    [self addSubview:tipLabel];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = (placeHolderTip.length) ? placeHolderTip : @"~暂无数据~";
    self.tipLabel = tipLabel;
}


- (void)setPlaceHolderTip:(NSString *)placeHolderTip {
    
    _placeHolderTip = placeHolderTip;
    self.tipLabel.text = placeHolderTip;
}

- (void)setPlaceHolderImage:(UIImage *)placeHolderImage {
    
    _placeHolderImage = placeHolderImage;
    self.imageV.image = placeHolderImage;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.completion) {
        self.completion();
    }
    
    if (self.target && self.action) {
        if ([self.target respondsToSelector:self.action]) {
            MsgSend(MsgTarget(self.target), self.action, self);
        }
    }
}

@end
