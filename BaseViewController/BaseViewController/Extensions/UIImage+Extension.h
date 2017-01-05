//
//  UIImage+Extension.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 圆形图片 适用于正方形切成圆形

 @param size size description
 @param fillColor fillColor description
 @param completion completion description
 */
- (void)jp_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

/**
 图片切圆角 适用于只切圆角
 
 @param size defalut--imageView size
 @param corner custom
 @param fillColor 填充颜色
 @param completion return--带圆角的图片
 */
- (void)jp_cornerImageWithSize:(CGSize)size corner:(CGFloat)corner fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

@end
