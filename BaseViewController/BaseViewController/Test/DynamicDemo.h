//
//  DynamicDemo.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/20.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 消息的动态解析  理解消息转发机制
 */
@interface DynamicDemo : NSObject

/** string */
@property(nonatomic,strong) NSString *string;

/** number */
@property(nonatomic,strong) NSNumber *number;

/** date */
@property(nonatomic,strong) NSDate *date;

/** obj */
@property(nonatomic,strong) id objc;



@end
