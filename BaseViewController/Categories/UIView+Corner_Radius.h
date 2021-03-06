//
//  UIView+Corner_Radius.h
//  teacherApp
//
//  Created by I Smile going on 15/12/1.
//  Copyright © 2015年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 为XIB添加设置圆角 半径
 */
@interface UIView (Corner_Radius)

@property(nonatomic,strong) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;

@end
