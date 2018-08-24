//
//  TestDataModel.m
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "TestDataModel.h"
#import "TestModel.h"



@implementation TestDataModel

- (void)setModel:(TestModel *)model {
    
    _model = model;
    
    self.bgViewFrame = CGRectMake((10), 0, SCREEN_WIDTH-2*(10), 100);
    
    self.iconFrame = CGRectMake((10), (10), 25, 25);
    
    CGSize nameSize = CL_TEXTSIZE(model.uname, CommonFontWithSize(14));
    self.nameLabelFrame = CGRectMake(CGRectGetMaxX(self.iconFrame)+(10), self.iconFrame.origin.y, nameSize.width+1, 25);
    
    self.timeLabelFrame = CGRectMake(CGRectGetMaxX(self.nameLabelFrame)+(10), self.iconFrame.origin.y, 100, 25);
    
    self.arrowFrame = CGRectMake(self.bgViewFrame.size.width-40, 0, 40, 35);
    
    BOOL isshow = [model.isshow boolValue];
    
    self.topBgFrame = CGRectMake(0, 0, SCREEN_WIDTH-2*(10), isshow ? 35 : 0);
    
    self.isShowTopIcon = isshow;
    
    CGFloat imageX = (7.5);
    CGFloat imageY = CGRectGetMaxY(self.topBgFrame) + (5);
    CGFloat imageW = self.bgViewFrame.size.width-2*(7.5);
    CGFloat imageH = (75);
    
    self.isShowDesc = NO;
    
    if (model.text.length) {
        
        NSMutableAttributedString * attributedString ;
        if ([model.type integerValue] == HomeMessageType_Text && model.click_txt && model.click_txt.length>0) {
            attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",model.text,model.click_txt]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:RGB_Same(53) range:NSMakeRange(0, attributedString.length>0)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:RGB(61, 209, 224) range:NSMakeRange(model.text.length, attributedString.length-model.text.length)];
            
        }else{
            attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.text]];
            [attributedString addAttribute:NSForegroundColorAttributeName value:RGB_Same(53) range:NSMakeRange(0, attributedString.length>0)];
        }
        [attributedString addAttribute:NSFontAttributeName value:CommonFontWithSize(14) range:NSMakeRange(0, attributedString.length)];
        CGFloat lineSpacing = 8;
        CGFloat textWidth = self.bgViewFrame.size.width-2*(10);
        if ([model.type integerValue] == HomeMessageType_RightImage) {
            textWidth = 210;
            lineSpacing = 0;
        }
        CGSize contentSize = [attributedString boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        
        if (contentSize.height > 20) {
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
            
            contentSize = [attributedString boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        }
        self.contentAttributed = attributedString;
        
        CGFloat textX = self.iconFrame.origin.x;
        CGFloat textY = CGRectGetMaxY(self.topBgFrame)+(10);
        CGFloat textH = contentSize.height+1;
        self.contentFrame = CGRectMake(textX, textY, textWidth, textH);
        
        self.bgViewFrame = CGRectMake((10), 0, SCREEN_WIDTH-2*(10), CGRectGetMaxY(self.contentFrame)+ (10));
        
        self.isShowContent = YES;
    }else {
        
        self.isShowContent = NO;
    }
    
    if ([model.type integerValue] == HomeMessageType_OneImage) {
        
        imageY = (5) + CGRectGetMaxY(self.topBgFrame);
        
        self.isShowOneImage = YES;
        self.isShowMoreImage = NO;
        
    }else if ([model.type integerValue] == HomeMessageType_MoreImage) {
        
        imageY = (5) + CGRectGetMaxY(self.contentFrame);
        imageX = (10);
        imageW = self.bgViewFrame.size.width - 2*(10);
        
        self.isShowOneImage = NO;
        self.isShowMoreImage = YES;
        
    }else if ([model.type integerValue] == HomeMessageType_RightImage) {
        
        CGFloat textWidth = CGRectGetWidth(self.contentFrame);
        CGFloat textX = CGRectGetMinX(self.contentFrame);
        
        CGSize descSize = [model.desc boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:CommonFontWithSize(11)} context:nil].size;
        self.descFrame = CGRectMake(textX, CGRectGetMaxY(self.contentFrame)+(10), textWidth, descSize.height+1);
        
        imageW = (115);
        imageX = self.bgViewFrame.size.width - imageW - (10);
        imageY = CGRectGetMaxY(self.topBgFrame);
        
        self.isShowOneImage = YES;
        self.isShowMoreImage = NO;
        self.isShowDesc = YES;
        
    }else {
        imageH = 0;
        
        self.isShowOneImage = NO;
        self.isShowMoreImage = NO;
        
    }
    self.imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
    
    if (imageH) {
        
        self.bgViewFrame = CGRectMake((10), 0, SCREEN_WIDTH-2*(10), CGRectGetMaxY(self.imageFrame)+(10));
    }else {
        self.bgViewFrame = CGRectMake((10), 0, SCREEN_WIDTH-2*(10), CGRectGetMaxY(self.contentFrame)+ (10));
        
    }
    
    self.cellHeight = CGRectGetMaxY(self.bgViewFrame)+(10);
    
    NSData *jsonData = [(NSString *)model.img_url dataUsingEncoding : NSUTF8StringEncoding];
    self.imageArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
    
    NSMutableArray *frames = [NSMutableArray array];
    for (NSInteger i = 0; i < self.imageArray.count ; i++) {
        
        CGFloat imageW = (self.imageFrame.size.width-(4.8*2))/3.0;
        CGRect imageFrame = CGRectMake(i*((4.8) + imageW), 0, imageW, self.imageFrame.size.height);
        [frames addObject:[NSValue valueWithCGRect:imageFrame]];
    }
    self.imageFrameArray = [frames copy];

}

@end
