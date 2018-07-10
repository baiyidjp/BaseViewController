//
//  UIImageView+JPWebImage.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/20.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SDWebImage)

/**
 封装SDWebImage
 
 @param url 图片地址
 @param placeholder 占位图
 */
- (void)jp_setSDImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder;

/**
 封装SDWebImage 适合正方形切圆形图片
 
 @param url 图片地址
 @param placeholder 占位图
 */
- (void)jp_setSDCornerImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder;

/**
 封装SDWebImage 加入切圆角

 @param url NSURL-图片地址
 @param placeholder 占位图
 @param cornerRadius 圆角半径0-imageViewWidth/2
 */
- (void)jp_setSDImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
              cornerRadius:(CGFloat)cornerRadius;


@end
