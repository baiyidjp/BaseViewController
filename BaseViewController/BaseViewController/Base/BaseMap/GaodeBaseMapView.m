//
//  GaodeBaseMapView.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "GaodeBaseMapView.h"

@interface GaodeBaseMapView ()

/** mapView */
@property(nonatomic,strong) MAMapView *mapView;

@end

@implementation GaodeBaseMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _mapView = [[MAMapView alloc]initWithFrame:frame];
        
    }
    return self;
}

- (UIView *)getView {
    
    return _mapView;
}


@end
