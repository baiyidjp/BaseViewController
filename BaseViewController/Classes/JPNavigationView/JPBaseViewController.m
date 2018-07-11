//
//  JPBaseViewController.m
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "JPBaseViewController.h"
#import "JPNavigationBar.h"
#import "JPNavItemButton.h"

@interface JPBaseViewController ()

/** 控制共用的NavigationBar 可直接Hidden隐藏 */
@property(nonatomic,strong) JPNavigationBar *jp_NavigationBar;
/** NavigationBar 上的 NavigationItem 导航条目 接收左右的item */
@property(nonatomic,strong) UINavigationItem *jp_NavigationItem;

@end

@implementation JPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self p_SetNavigationBar];
}

//状态栏的背景色
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (JPNavigationBar *)jp_NavigationBar{
    
    if (!_jp_NavigationBar) {
        
        _jp_NavigationBar = [[JPNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, NAVIGATION_BAR_HEIGHT)];
    }
    return _jp_NavigationBar;
}

- (UINavigationItem *)jp_NavigationItem{
    
    if (!_jp_NavigationItem) {
        
        _jp_NavigationItem = [[UINavigationItem alloc] init];;
    }
    return _jp_NavigationItem;
}

//重写系统设置title的setter
- (void)setTitle:(NSString *)title {
    
    //正常创建控制器是先执行[alloc init] 后执行这句 在执行时在给予赋值
    self.jp_NavigationItem.title = title;
}


#pragma mark -设置导航栏
- (void)p_SetNavigationBar {
    
    [self.view addSubview:self.jp_NavigationBar];
    
    //将导航条目 添加到导航条
    self.jp_NavigationBar.items = @[self.jp_NavigationItem];
    //导航条的渲染颜色
    self.jp_NavigationBar.barTintColor = [UIColor jp_colorWithHexString:@"F6F6F6"];
    //设置 bar 的标题字体颜色
    self.jp_NavigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor purpleColor]};
}

- (void)setIsHiddenNavigationBar:(BOOL)isHiddenNavigationBar {
    
    _isHiddenNavigationBar = isHiddenNavigationBar;
    self.jp_NavigationBar.hidden = isHiddenNavigationBar;
}

- (void)jp_HiddenNavigationBarAndShowBackBtn:(BOOL)isShow {
    
    self.jp_NavigationBar.hidden = YES;
    
    if (isShow) {
        //创建btn
        JPNavItemButton *backBtn = [[JPNavItemButton alloc] initWithFrame:CGRectMake(8, STATUS_BAR_HEIGHT, 44, 44)];
        backBtn.isLeft = YES;
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_withtext"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_withtext"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(p_ClickBackBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backBtn];
        
    }
}

- (void)p_ClickBackBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setJp_NavigationAlpha:(CGFloat)jp_NavigationAlpha {
    
    _jp_NavigationAlpha = jp_NavigationAlpha;
    self.jp_NavigationBar.alpha = jp_NavigationAlpha;
}

- (void)setJp_BarTintColor:(UIColor *)jp_BarTintColor {
    
    _jp_BarTintColor = jp_BarTintColor;
    self.jp_NavigationBar.barTintColor = jp_BarTintColor;
}

- (void)setJp_BarTitleTextColor:(UIColor *)jp_BarTitleTextColor {
    
    _jp_BarTitleTextColor = jp_BarTitleTextColor;
    self.jp_NavigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : jp_BarTitleTextColor};
}

- (void)setJp_BarTitleFont:(UIFont *)jp_BarTitleFont {
    
    _jp_BarTitleFont = jp_BarTitleFont;
    self.jp_NavigationBar.titleTextAttributes = @{NSFontAttributeName : jp_BarTitleFont};
}

- (void)jp_SetNavigationBackItemWithTarget:(id)target action:(SEL)action {
    
    [self jp_SetNavigationItemWithInfoString:@"navigationbar_back_withtext" Type:JPNavigationItemType_Image Layout:YES FixSpace:YES target:target action:action];
}

- (void)jp_SetNavigationRightTextItemWithInfoString:(NSString *)infoStr target:(id)target action:(SEL)action {
    
    [self jp_SetNavigationItemWithInfoString:infoStr Type:JPNavigationItemType_Text Layout:NO FixSpace:YES target:target action:action];
}

- (void)jp_SetNavigationItemWithInfoString:(NSString *)infoStr Type:(JPNavigationItemType)type Layout:(BOOL)isLeft FixSpace:(BOOL)isFix target:(id)target action:(SEL)action {
    
    UIBarButtonItem *item;
    
    if (type == JPNavigationItemType_Text) {
        item = [[UIBarButtonItem alloc] initWithItemTitle:infoStr Layout:isLeft target:target action:action];
    }
    
    if (type == JPNavigationItemType_Image) {
        item = [[UIBarButtonItem alloc] initWithItemImageName:infoStr Layout:isLeft target:target action:action];
    }
    
    if (isFix) {
        //为了缩进
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = -5;
        NSArray *items = @[spaceItem,item];
        if (!isLeft) {
            items = @[item,spaceItem];
        }
        [self jp_SetItems:items Layout:isLeft];
    }else {
        [self p_SetItem:item Layout:isLeft];
    }
}

- (void)p_SetItem:(UIBarButtonItem *)item Layout:(BOOL)isLeft {
    
    if (isLeft) {
        self.jp_NavigationItem.leftBarButtonItem = item;
    }else {
        self.jp_NavigationItem.rightBarButtonItem = item;
    }
}

- (void)jp_SetItems:(NSArray *)items Layout:(BOOL)isLeft {
    
    if (isLeft) {
        self.jp_NavigationItem.leftBarButtonItems = items;
    }else {
        self.jp_NavigationItem.rightBarButtonItems = items;
    }
}

- (void)jp_CancelScrollViewInsetWithTableView:(UITableView *)tableview {
    
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void)jp_AddSubView:(UIView *)view belowNavigationBar:(BOOL)isBelow {
    
    if (isBelow) {
        [self.view insertSubview:view belowSubview:self.jp_NavigationBar];
    }else {
        [self.view insertSubview:view aboveSubview:self.jp_NavigationBar];
    }
}

@end
