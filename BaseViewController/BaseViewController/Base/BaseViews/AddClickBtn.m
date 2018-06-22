//
//  AddClickBtn.m
//  BaseViewController
//
//  Created by baiyi on 2018/4/2.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "AddClickBtn.h"

@implementation AddClickBtn

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event

{
    
    CGRect bounds = self.bounds;
    
    bounds = CGRectInset(bounds, -30, 0);
    
    return CGRectContainsPoint(bounds, point);
    
}

@end
