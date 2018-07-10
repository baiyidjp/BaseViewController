//
//  MidLineLabel.m
//  MeiKeLaMei
//
//  Created by tztddong on 16/6/23.
//  Copyright © 2016年 gyk. All rights reserved.
//

#import "MidLineLabel.h"

@implementation MidLineLabel


- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.textColor setStroke];
    CGFloat y = rect.size.height*0.5;
    CGContextMoveToPoint(context, 0, y);
    CGSize size = [self.text sizeWithAttributes:[NSMutableDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName]];
    CGContextAddLineToPoint(context, size.width, y);
    CGContextStrokePath(context);
}


@end
