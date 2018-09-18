//
//  JPTimerManager.m
//  BaseViewController
//
//  Created by baiyi on 2018/9/13.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "JPTimerManager.h"

@implementation JPTimerManager

//存储所有的 timer 一个标识一个timer
static NSMutableDictionary *_timersDict;
//信号量 用来加锁
dispatch_semaphore_t _semaphore;

+ (void)initialize {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _timersDict = [NSMutableDictionary dictionary];
        _semaphore = dispatch_semaphore_create(1);
    });
    
}

+ (NSString *)timerBeginWithStartTime:(NSTimeInterval)startTime intervalTime:(NSTimeInterval)intervalTime repeats:(BOOL)repeats async:(BOOL)async task:(void (^)(void))task {
    
    if (startTime < 0 || (repeats && intervalTime <= 0) || !task) {
        NSLog(@"参数错误,检查入参");
        return nil;
    }
    
    //队列
    dispatch_queue_t queue_t = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    //创建timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue_t);
    //设置timer的开始时间
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, startTime * NSEC_PER_SEC),  intervalTime * NSEC_PER_SEC, 0);
    
    /****************************加锁******************************/
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    //设置定时器的唯一标识
    NSString *timerName = [NSString stringWithFormat:@"timerName_%zd",_timersDict.count];
    //存储到字典中
    [_timersDict setObject:timer forKey:timerName];
    
    /****************************解锁******************************/
    dispatch_semaphore_signal(_semaphore);
    
    //定时器的回调
    dispatch_source_set_event_handler(timer, ^{
        //回调方法
        task();
        
        //判断是否是一次性任务
        if (!repeats) {
            [self cancelTask:timerName];
        }
    });
    dispatch_resume(timer);
    
    return timerName;
}

+ (NSString *)timerBeginWithStartTime:(NSTimeInterval)startTime intervalTime:(NSTimeInterval)intervalTime repeats:(BOOL)repeats async:(BOOL)async target:(id)target selector:(SEL)selector {
    
    if (!target || !selector) {
        NSLog(@"参数错误,检查入参");
        return nil;
    }
    
    return [self timerBeginWithStartTime:startTime intervalTime:intervalTime repeats:repeats async:async task:^{
        
        if ([target respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    }];
}

+ (void)cancelTask:(NSString *)name {
    
    if (!name || !name.length) {
        NSLog(@"参数错误,检查入参");
        return;
    }
    
    /****************************加锁******************************/
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    
    //取出timer
    dispatch_source_t timer = [_timersDict objectForKey:name];
    //取消定时器
    if (timer) {
        dispatch_cancel(timer);
        //从字典中移除
        [_timersDict removeObjectForKey:name];
    }

    /****************************解锁******************************/
    dispatch_semaphore_signal(_semaphore);
}

@end
