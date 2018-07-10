//
//  IMapEngine.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "IMapEngine.h"
#import "BaiduMapFactory.h"
#import "GaodeMapFactory.h"

@implementation IMapEngine

+ (instancetype)sharedEngine {
    
    static IMapEngine *mapEngine;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapEngine = [[IMapEngine alloc] init];
    });
    return mapEngine;
}

- (id<IMapFactory>)getMapFactoryType:(SDKType)type {
    
    switch (type) {
        case SDKType_BD:
            return [[BaiduMapFactory alloc] init];
            break;
        case SDKType_GD:
            return [[GaodeMapFactory alloc] init];
            break;
    }
}

@end
