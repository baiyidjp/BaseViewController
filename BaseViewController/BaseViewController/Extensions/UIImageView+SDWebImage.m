//
//  UIImageView+JPWebImage.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/20.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "UIImageView+SDWebImage.h"
#import "UIImage+Extension.h"

@implementation UIImageView (SDWebImage)

-(void)jp_setSDImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    
    [self jp_setSDImageWithURL:url placeholderImage:placeholder cornerRadius:0];
}

- (void)jp_setSDCornerImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    
    [self jp_setSDImageWithURL:url placeholderImage:placeholder cornerRadius:self.bounds.size.width/2.0];
}

- (void)jp_setSDImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder cornerRadius:(CGFloat)cornerRadius {
    
    __weak typeof(self) weakSelf = self;
    
    //默认使用占位图
    self.image = [placeholder jp_cornerImageWithSize:self.bounds.size cornerRadius:cornerRadius fillColor:self.superview.backgroundColor];
    
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [image jp_asynCornerImageWithSize:self.bounds.size cornerRadius:cornerRadius fillColor:self.superview.backgroundColor completion:^(UIImage *resultImage) {
            weakSelf.image = resultImage;
        }];
    }];
}

@end
