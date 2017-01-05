//
//  UIView+Corner_Radius.m
//  teacherApp
//
//  Created by I Smile going on 15/12/1.
//  Copyright © 2015年 dong. All rights reserved.
//

#import "UIView+Corner_Radius.h"
#import <objc/runtime.h>

@implementation UIView (CornerRadius)

#pragma mark - setter & getter

- (void)setCornerRadius:(CGFloat)cornerRadius {
    objc_setAssociatedObject(self, @"cornerRadius", @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius {
    id value = objc_getAssociatedObject(self, @"cornerRadius");
    return [value floatValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    objc_setAssociatedObject(self, @"borderWidth", @(borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    
}

- (CGFloat)borderWidth {
    return [objc_getAssociatedObject(self, @"borderWidth") floatValue];
}

- (void)setBorderColor:(UIColor *)borderColor {
    objc_setAssociatedObject(self, @"borderColor", borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, @"borderColor");
}
@end
