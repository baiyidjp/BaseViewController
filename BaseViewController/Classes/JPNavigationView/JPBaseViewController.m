//
//  JPBaseViewController.m
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "JPBaseViewController.h"

@interface JPBaseViewController ()

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
    //设置系统的UIBarbuttonItem的字体颜色
//    self.jp_NavigationBar.tintColor = [UIColor redColor];

}

- (void)setJp_BarTintColor:(UIColor *)jp_BarTintColor {
    
    self.jp_NavigationBar.barTintColor = jp_BarTintColor;
}

- (void)setJp_BarTitleTextColor:(UIColor *)jp_BarTitleTextColor {
    
    self.jp_NavigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : jp_BarTitleTextColor};
}

- (void)setJp_BarTitleFont:(UIFont *)jp_BarTitleFont {
    
    self.jp_NavigationBar.titleTextAttributes = @{NSFontAttributeName : jp_BarTitleFont};
}

@end
