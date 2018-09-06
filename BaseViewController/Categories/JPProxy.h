//
//  JPProxy.h
//  BaseViewController
//
//  Created by baiyi on 2018/9/6.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 利用中间代理解决循环引用: NSTimer(CADisplayLink) 与 当前控制器 互相强引用 无法释放.
 */
@interface JPProxy : NSProxy

@property(nonatomic,weak)id target;

- (instancetype)initWithTarget:(id)target;

@end

