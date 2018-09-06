//
//  JPProxy.m
//  BaseViewController
//
//  Created by baiyi on 2018/9/6.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "JPProxy.h"

@implementation JPProxy

- (instancetype)initWithTarget:(id)target {
    
    JPProxy *proxy = [JPProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    [invocation invokeWithTarget:self.target];
}

@end
