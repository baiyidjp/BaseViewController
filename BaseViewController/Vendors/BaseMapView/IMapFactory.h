//
//  IMapFactory.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMapView.h"

//地图工厂协议
@protocol IMapFactory <NSObject>

//生成MapView流水线

- (id<IMapView>)getMapView:(CGRect)frame;

//生成地图定位的流水线

@end
