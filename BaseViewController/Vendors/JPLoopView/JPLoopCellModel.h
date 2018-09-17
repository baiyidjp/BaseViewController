//
//  JPLoopCellModel.h
//  BaseViewController
//
//  Created by baiyi on 2018/9/17.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JPLoopViewTitleAliment) {
    JPLoopViewTitleAlimentNone,//隐藏文本
    JPLoopViewTitleAlimentLeft,
    JPLoopViewTitleAlimentCenter,
    JPLoopViewTitleAlimentRight
};


@interface JPLoopCellModel : NSObject

/** URL */
@property(nonatomic,copy)NSString *imageUrlStr;
/** placeholderimage */
@property(nonatomic,strong) UIImage *placeholderImage;

/** showtext */
@property(nonatomic,assign) BOOL isShowTitle;
/** text */
@property(nonatomic,copy)NSString *imageTitleStr;
/** titletype */
@property(nonatomic,assign) JPLoopViewTitleAliment titleAliment;
/** titlefont */
@property(nonatomic,strong) UIFont *titleFont;
/** title color*/
@property(nonatomic,strong) UIColor *titleColor;
/** leftOffset 左边距离BgView的间距 默认10 */
@property(nonatomic,assign) CGFloat titleLeftOffset;
/** rightOffset 右边距离BgView的间距 默认10 */
@property(nonatomic,assign) CGFloat titleRightOffset;

/** bgcolor */
@property(nonatomic,strong) UIColor *bgViewColor;
/** bgView 左边的间距 默认0 */
@property(nonatomic,assign) CGFloat bgViewLeftOffset;
/** bgView 右边边的间距 默认0 */
@property(nonatomic,assign) CGFloat bgViewRightOffset;
/** bgView 下边的间距 默认0 */
@property(nonatomic,assign) CGFloat bgViewBottomOffset;
/** bgView height */
@property(nonatomic,assign) CGFloat bgViewHeight;

@end
