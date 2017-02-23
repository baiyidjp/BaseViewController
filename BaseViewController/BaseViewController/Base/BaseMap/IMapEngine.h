//
//  IMapEngine.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMapFactory.h"

typedef enum : NSUInteger {
    SDKType_BD,
    SDKType_GD,
} SDKType;

//地图引擎 (简单的工厂模式)
@interface IMapEngine : NSObject

//定义规范 以供外部调用

+ (instancetype)sharedEngine;

//返回工厂协议
- (id<IMapFactory>)getMapFactoryType:(SDKType)type;

@end
