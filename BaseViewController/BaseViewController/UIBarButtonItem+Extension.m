//
//  UIBarButtonItem+Extension.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

- (UIBarButtonItem *)initWithTitle:(NSString *)title fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action isBack:(BOOL)isBack {
    
    self = [self init];
    if (self) {
        //创建btn
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        //判断是否是带返回图片的
        if (isBack) {    
            NSString *imageName = @"navigationbar_back_withtext";
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
        }
        
        [btn sizeToFit];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        self.customView = btn;
    }
    return self;
    
}


@end
