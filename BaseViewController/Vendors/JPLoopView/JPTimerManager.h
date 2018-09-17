//
//  JPTimerManager.h
//  BaseViewController
//
//  Created by baiyi on 2018/9/13.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPTimerManager : NSObject

/**
 启动GCD定时器(Block回调处理事件)

 @param startTime 开始时间
 @param intervalTime 间隔时间 > 0
 @param repeats 是否重复执行 = NO 只执行一次(此时intervaltime无用)
 @param async 是否是异步
 @param task 处理事件回调
 @return 当前定时器的唯一标识
 */
+ (NSString *)timerBeginWithStartTime:(NSTimeInterval)startTime
                         intervalTime:(NSTimeInterval)intervalTime
                              repeats:(BOOL)repeats
                                async:(BOOL)async
                                 task:(void(^)(void))task;

/**
 启动GCD定时器(SEL处理事件)

 @param startTime 开始时间
 @param intervalTime 间隔时间 > 0
 @param repeats 是否重复执行 = NO 只执行一次(此时intervaltime无用)
 @param async 是否是异步
 @param target 消息接收者
 @param selector 方法名
 @return 当前定时器的唯一标识
 */
+ (NSString *)timerBeginWithStartTime:(NSTimeInterval)startTime
                         intervalTime:(NSTimeInterval)intervalTime
                              repeats:(BOOL)repeats
                                async:(BOOL)async
                               target:(id)target
                             selector:(SEL)selector;

/**
 取消定时器

 @param name 要取消的定时器的唯一标识
 */
+ (void)cancelTask:(NSString *)name;

@end
