//
//  UIImage+Extension.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/5.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "UIImage+Extension.h"
#import <objc/runtime.h>

@implementation UIImage (Extension)

//+ (void)load{
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        Class aclass = object_getClass((id)self);
//        
//        Method originalMethod = class_getClassMethod(aclass, @selector(imageNamed:));
//        Method swizzledMethod = class_getClassMethod(aclass, @selector(bundleImageNamed:));
//        
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//        
//    });
//}
//
//#pragma mark - 替换
//+ (UIImage *)bundleImageNamed:(NSString *)imageName{
//    
//    NSString * path = [[NSBundle mainBundle] pathForResource:@"VCReadBundle" ofType:@"bundle"];
//    NSString *imagePath = [path stringByAppendingPathComponent:@"Image"];
//    NSString *img_path = [imagePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",imageName]];
//    
//    return [UIImage imageWithContentsOfFile:img_path];
//    
//}

- (UIImage *)jp_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor {
    
    return [self jp_cornerImageWithSize:size cornerRadius:size.width/2.0 fillColor:fillColor];
}

- (UIImage *)jp_cornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor {
    
    //使用绘图 取得上下文
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    //绘制范围
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    //设置填充颜色
    [fillColor setFill];
    UIRectFill(rect);
    
    //使用贝塞尔曲线设置裁切路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    //裁切
    [path addClip];
    
    //将图片重绘到已经裁切过的上下文中
    [self drawInRect:rect];
    
    //取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return image;

}

- (void)jp_asynCornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion {
    
    [self jp_asynCornerImageWithSize:size cornerRadius:size.width/2.0 fillColor:fillColor completion:completion];
}


- (void)jp_asynCornerImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *))completion {
    
    //异步绘制
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //使用绘图 取得上下文
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        
        //绘制范围
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        //设置填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        
        if (cornerRadius) {
            
            //使用贝塞尔曲线设置裁切路径
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
            //裁切
            [path addClip];
        }        
        
        //将图片重绘到已经裁切过的上下文中
        [self drawInRect:rect];
        
        //取出图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        //结束上下文
        UIGraphicsEndImageContext();
        
        //主线程调用block返回图片
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (completion) {
                completion(image);
            }
        });
        
    });
    
    
}
@end
