//
//  UIBarButtonItem+Extension.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIButton+AddClick.h"
#import "UIColor+JP_Color.h"

@implementation UIBarButtonItem (Extension)

- (UIBarButtonItem *)initWithTitle:(NSString *)title fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action isBack:(BOOL)isBack {
    
    self = [self init];
    if (self) {
        //创建btn
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        [btn setTitleColor:[UIColor jp_colorWithHexString:@"3DD1E0"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        //判断是否是带返回图片的
        if (isBack) {    
            NSString *imageName = @"navigationbar_back_withtext";
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
        }
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (systemVersion >= 11) {
            
            [btn setHitTestEdgeInsets:UIEdgeInsetsMake(-30, -30, -30, -30)];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        }


        self.customView = btn;
    }
    return self;
    
}


@end
