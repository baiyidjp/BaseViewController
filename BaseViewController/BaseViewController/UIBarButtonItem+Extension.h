//
//  UIBarButtonItem+Extension.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

- (UIBarButtonItem *)initWithTitle:(NSString *)title fontSize:(CGFloat)fontSize target:(id)target action:(SEL)action isBack:(BOOL)isBack;

@end
