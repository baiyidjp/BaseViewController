//
//  GaodeMapFactory.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "GaodeMapFactory.h"
#import "GaodeBaseMapView.h"

@implementation GaodeMapFactory

- (instancetype)init
{
    self = [super init];
    if (self) {
        //高德地图SDK初始化
        [AMapServices sharedServices].apiKey =@"c6a8323db21ecf6a86ae761b725e60ca";
    }
    return self;
}

//高德工厂 生成高德地图的view
- (id<IMapView>)getMapView:(CGRect)frame {
    
    return [[GaodeBaseMapView alloc] initWithFrame:frame];
}

@end
