//
//  UIImageView+LoadImage.m
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "UIImageView+JPWebImage.h"
#import "UIImage+Extension.h"

@implementation UIImageView (JPWebImage)

- (void)jp_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self jp_setImageWithURL:url placeholderImage:placeholder cornerRadius:0];
}

- (void)jp_setCornerImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self jp_setImageWithURL:url placeholderImage:placeholder cornerRadius:self.bounds.size.width/2.0];
}

- (void)jp_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder cornerRadius:(CGFloat)cornerRadius {
    
    if (!url){
        return;
    }
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JPDownloadImageCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if(!isDirExist){
        
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bCreateDir) {
            NSLog(@"创建文件出错");
            return;
        }
    }
    NSString *urlString = [url absoluteString];
    NSString *imageName = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *pathString = [[path stringByAppendingString:@"/"] stringByAppendingString:imageName];
    NSData *saveData = [NSData dataWithContentsOfFile:pathString];
    UIImage *saveImage = placeholder;
    //占位图
    self.image = [saveImage jp_cornerImageWithSize:self.bounds.size cornerRadius:cornerRadius fillColor:self.superview.backgroundColor];
    //本地缓存
    if (saveData) {
        saveImage = [UIImage imageWithData:saveData];
        self.image = [saveImage jp_cornerImageWithSize:self.bounds.size cornerRadius:cornerRadius fillColor:self.superview.backgroundColor];
        return;
    }
    //创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建会话请求
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (location && location.absoluteString.length) {
                
                [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:pathString] error:nil];
                NSData *saveData = [NSData dataWithContentsOfFile:pathString];
                UIImage *saveImage = placeholder;
                if (saveData) {
                    saveImage = [UIImage imageWithData:saveData];
                }
                [saveImage jp_asynCornerImageWithSize:self.bounds.size cornerRadius:cornerRadius fillColor:self.superview.backgroundColor completion:^(UIImage *resultImage) {
                    self.image = resultImage;
                }];
            }
        });
    }];
    //发送请求
    [downTask resume];
}

@end
