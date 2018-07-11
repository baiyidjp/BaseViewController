//
//  JPBaseViewController.h
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JPNavigationItemType) {
    JPNavigationItemType_None,
    JPNavigationItemType_Text,//文本
    JPNavigationItemType_Image//图片
};

@interface JPBaseViewController : UIViewController

/** 是否隐藏导航栏后展示返回按钮 */
- (void)jp_HiddenNavigationBarAndShowBackBtn:(BOOL)isShow;
/** 导航栏隐藏 */
@property(nonatomic,assign) BOOL isHiddenNavigationBar;
/** 导航栏透明度 */
@property(nonatomic,assign) CGFloat jp_NavigationAlpha;

/** 导航条的颜色 */
@property(nonatomic,strong) UIColor *jp_BarTintColor;
/** 导航大标题的颜色 */
@property(nonatomic,strong) UIColor *jp_BarTitleTextColor;
/** 导航标题的字号 */
@property(nonatomic,strong) UIFont *jp_BarTitleFont;

/**
 设置Item
 
 @param infoStr 图片名/文本
 @param type 图片/文本
 @param isLeft 是左/右 左=YES
 @param isFix 是否需要弹簧
 @param target 代理
 @param action 点击事件
 */
- (void)jp_SetNavigationItemWithInfoString:(NSString *)infoStr Type:(JPNavigationItemType)type Layout:(BOOL)isLeft FixSpace:(BOOL)isFix target:(id)target action:(SEL)action;

/**
 设置返回item
 
 @param target 代理
 @param action 事件
 */
- (void)jp_SetNavigationBackItemWithTarget:(id)target action:(SEL)action;

/**
 设置右上角文本item
 
 @param infoStr 文本
 @param target 代理
 @param action 事件
 */
- (void)jp_SetNavigationRightTextItemWithInfoString:(NSString *)infoStr target:(id)target action:(SEL)action;
/**
 设置items
 
 @param items items
 @param isLeft 是否是左边
 */
- (void)jp_SetItems:(NSArray *)items Layout:(BOOL)isLeft;

/**
 取消滚动视图的缩进

 @param tableview 滚动视图
 */
- (void)jp_CancelScrollViewInsetWithTableView:(UITableView *)tableview;

/**
 将子View 放在Bar之下还是之上

 @param view 子view
 @param isBelow BOOL
 */
- (void)jp_AddSubView:(UIView *)view belowNavigationBar:(BOOL)isBelow;
@end
