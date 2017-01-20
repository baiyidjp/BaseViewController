//
//  UIImageView+LoadImage.h
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JPWebImage)

/**
 模仿SDWebImange下载
 
 @param url NSURL图片地址
 @param placeholder 占位图
 */
- (void)jp_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder;

/**
 模仿SDWebImange下载 适合正方形切圆形图片
 
 @param url NSURL图片地址
 @param placeholder 占位图
 */
- (void)jp_setCornerImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder;

/**
 模仿SDWebImange下载 并加入切圆角

 @param url NSURL图片地址
 @param placeholder 占位图
 @param cornerRadius 圆角半径0-imageView的Width/2
 */
- (void)jp_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
              cornerRadius:(CGFloat)cornerRadius;

@end
