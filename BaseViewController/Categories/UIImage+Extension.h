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
 圆形图片

 @param size size description
 @param fillColor fillColor description
 @return return value description
 */
- (UIImage *)jp_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor;

/**
 直接切圆角 返回图片

 @param size size description
 @param cornerRadius cornerRadius description
 @param fillColor fillColor description
 @return return value description
 */
- (UIImage *)jp_cornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor;

/**
 异步圆形图片 适用于正方形切成圆形

 @param size size description
 @param fillColor fillColor description
 @param completion completion description
 */
- (void)jp_asynCornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

/**
 异步图片切圆角 适用于只切圆角
 
 @param size defalut--imageView size
 @param cornerRadius custom =0->不作处理的原图
 @param fillColor 填充颜色
 @param completion return--带圆角的图片
 */
- (void)jp_asynCornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image))completion;

@end
