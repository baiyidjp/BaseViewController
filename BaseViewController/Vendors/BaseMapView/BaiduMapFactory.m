//
//  BaiduMapFactory.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaiduMapFactory.h"
#import "BaiduBaseMapView.h"

@implementation BaiduMapFactory

- (instancetype)init
{
    self = [super init];
    if (self) {
        //百度地图SDK初始化
        BMKMapManager *mapManager = [[BMKMapManager alloc]init];
        // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
        BOOL ret = [mapManager start:@"fccLTM49WhsgpjDhwZhmi9Gaj1iYR5Vy"  generalDelegate:nil];
        if (!ret) {
            NSLog(@"manager start failed!");
        }

    }
    return self;
}

//百度工厂 生成百度的MapView
- (id<IMapView>)getMapView:(CGRect)frame {
    
    return [[BaiduBaseMapView alloc] initWithFrame:frame];
}

@end
