//
//  UIBarButtonItem+CustomItem.m
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "UIBarButtonItem+JPItem.h"
#import "JPNavItemButton.h"

@implementation UIBarButtonItem (JPItem)

- (UIBarButtonItem *)initWithItemImageName:(NSString *)itemImageName target:(id)target action:(SEL)action {
    
    return [self initWithItemImageName:itemImageName HighImageName:nil ItemTitle:nil TitleColor:nil HighTitleColor:nil TitleFont:0 Bold:NO Layout:YES target:target action:action];
}

- (UIBarButtonItem *)initWithItemImageName:(NSString *)itemImageName Layout:(BOOL)isLeft target:(id)target action:(SEL)action {
    
    return [self initWithItemImageName:itemImageName HighImageName:nil ItemTitle:nil TitleColor:nil HighTitleColor:nil TitleFont:0 Bold:NO Layout:isLeft target:target action:action];

}

- (UIBarButtonItem *)initWithItemTitle:(NSString *)itemTitle Layout:(BOOL)isLeft target:(id)target action:(SEL)action {
    
    return [self initWithItemImageName:nil HighImageName:nil ItemTitle:itemTitle TitleColor:[UIColor blackColor] HighTitleColor:[UIColor blackColor] TitleFont:16 Bold:NO Layout:isLeft target:target action:action];
}

- (UIBarButtonItem *)initWithItemImageName:(NSString *)itemImageName HighImageName:(NSString *)highImageName ItemTitle:(NSString *)itemTitle TitleColor:(UIColor *)titleColor HighTitleColor:(UIColor *)highTitleColor TitleFont:(CGFloat)titleFont Bold:(BOOL)isBold Layout:(BOOL)isLeft target:(id)target action:(SEL)action {
    
    self = [self init];
    if (self) {
        //创建btn
        JPNavItemButton *btn = [[JPNavItemButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setTitle:itemTitle forState:UIControlStateNormal];
        [btn.titleLabel setFont:isBold ? [UIFont boldSystemFontOfSize:titleFont] : [UIFont systemFontOfSize:titleFont]];
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn setTitleColor:highTitleColor ? highTitleColor : titleColor forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:itemImageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:highImageName.length ? highImageName : itemImageName] forState:UIControlStateHighlighted];
        if (itemTitle.length) {
            [btn sizeToFit];
        }else {
            btn.isLeft = isLeft;
        }
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        self.customView = btn;
    }
    return self;

}

@end
