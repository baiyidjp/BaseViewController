//
//  UIBarButtonItem+Extension.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 创建一个自定义的UIBarButtonItem

 @param title 标题
 @param fontSize 字号
 @param target 响应者
 @param action 点击事件
 @param isBack 是否带返回图片
 @return return value description
 */
- (UIBarButtonItem *)initWithTitle:(NSString *)title fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action isBack:(BOOL)isBack;

@end
