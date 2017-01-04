//
//  UIButton+RemoveHighlightEffect.m
//  Weibo16
//
//  Created by 0426iOS on 15/8/8.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//

#import "UIButton+RemoveHighlightEffect.h"
#import <objc/runtime.h>

#define KEY @"removeHighlightEffect"

@implementation UIButton (RemoveHighlightEffect)

//如果一个类身上有A方法,我们用B方法去把其替换了,然后在外面执行这个类身上的A方法的时候,会执行B方法

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(setHighlighted:);
        SEL swizzledSelector = @selector(iw_setHighlighted:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)iw_setHighlighted:(BOOL)highlighted
{
    if (!self.removeHighlightEffect) {
        //如果用户没有设置removeHighlightEffect为Yes,就执行原有的方法,而原有的方法已经被我们替换,所以就执行当前这个方法
        [self iw_setHighlighted:highlighted];
    }
}

- (void)setRemoveHighlightEffect:(BOOL)removeHighlightEffect
{
    objc_setAssociatedObject(self, KEY, @(removeHighlightEffect), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)removeHighlightEffect
{
    return [objc_getAssociatedObject(self, KEY) boolValue];
}

@end
