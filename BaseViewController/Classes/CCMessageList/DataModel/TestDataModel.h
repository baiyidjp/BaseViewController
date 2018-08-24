//
//  TestDataModel.h
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HomeMessageType) {
    
    HomeMessageType_None = -1,// 无
    HomeMessageType_Text,//0 纯文字
    HomeMessageType_OneImage,//1 一张图+文字
    HomeMessageType_BannerImage,//2 banner图
    HomeMessageType_LoopImage,//3 轮播图
    HomeMessageType_MoreImage,//4 多张图
    HomeMessageType_RightImage//5 左右布局
};

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)      RGBA(r,g,b,1.0f)
#define RGB_Same(rgb)      RGBA(rgb,rgb,rgb,1.0f)
#define RGBA_Same(rgb,a)      RGBA(rgb,rgb,rgb,a)

// 计算文本size
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define CL_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define CL_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#define CommonFontWithSize(s)  [UIFont systemFontOfSize:s]

@class TestModel;
@interface TestDataModel : NSObject

/** model */
@property(nonatomic,strong) TestModel *model;

@property (nonatomic,strong) NSMutableAttributedString * contentAttributed;
/** 图片集合 */
@property(nonatomic,strong) NSArray *imageArray;
/** 图片集合的frame */
@property(nonatomic,strong) NSArray *imageFrameArray;

@property (nonatomic,assign) CGRect topBgFrame;
@property (nonatomic,assign) CGRect iconFrame;
@property (nonatomic,assign) CGRect nameLabelFrame;
@property (nonatomic,assign) CGRect timeLabelFrame;
@property (nonatomic,assign) CGRect arrowFrame;
@property (nonatomic,assign) CGRect contentFrame;
@property (nonatomic,assign) CGRect descFrame;
@property (nonatomic,assign) CGRect imageFrame;
@property (nonatomic,assign) CGRect bgViewFrame;

@property (nonatomic,assign) CGFloat cellHeight;

/** 展示文字 */
@property(nonatomic,assign) BOOL isShowContent;
/** 展示副标题 */
@property(nonatomic,assign) BOOL isShowDesc;
/** 展示单图 */
@property(nonatomic,assign) BOOL isShowOneImage;
/** 展示多图 */
@property(nonatomic,assign) BOOL isShowMoreImage;
/** 展示顶部头像栏 */
@property(nonatomic,assign) BOOL isShowTopIcon;

@end
