//
//  UIViewController+NSLogAppear.m
//  runtime
//
//  Created by tztddong on 2016/10/20.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "UIViewController+NSLogAppear.h"
#import <objc/runtime.h>

@implementation UIViewController (NSLogAppear)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class aClass = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(log_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
        
        // When swizzling a class method, use the following:
        // Class aClass = object_getClass((id)self);
        // ...
        // Method originalMethod = class_getClassMethod(aClass, originalSelector);
        // Method swizzledMethod = class_getClassMethod(aClass, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(aClass,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(aClass,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

- (void)log_viewWillAppear:(BOOL)animated {
    
    [self log_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}

@end
