//
//  BaiduMapView.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaiduBaseMapView.h"

@interface BaiduBaseMapView ()

/** mapView */
@property(nonatomic,strong) BMKMapView *mapView;

@end

@implementation BaiduBaseMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _mapView = [[BMKMapView alloc]initWithFrame:frame];

    }
    return self;
}

- (UIView *)getView {
    
    return _mapView;
}

@end
