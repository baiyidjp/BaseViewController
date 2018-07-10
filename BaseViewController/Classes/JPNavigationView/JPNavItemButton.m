//
//  JPNavItemButton.m
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "JPNavItemButton.h"

@implementation JPNavItemButton

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = 0;
    if (self.isLeft) {
    }else {
        imageFrame.origin.x = self.frame.size.width-imageFrame.size.width;
    }
    self.imageView.frame = imageFrame;
}

@end
