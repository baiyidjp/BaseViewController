//
//  BaseViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/3.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+JP_Frame.h"
#import "UIColor+JP_Color.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    //设置导航条
    [self setupNavigationBar];
}

//懒加载

- (UINavigationBar *)baseNavigationBar{
    
    if (!_baseNavigationBar) {
        
        _baseNavigationBar =  [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    }
    return _baseNavigationBar;
}

- (UINavigationItem *)baseNavigationItem{
    
    if (!_baseNavigationItem) {
        
        _baseNavigationItem = [[UINavigationItem alloc] init];
    }
    return _baseNavigationItem;
}

//重写系统设置title的setter
- (void)setTitle:(NSString *)title {
    //正常创建控制器是先执行[alloc init] 后执行这句 在执行时在给予赋值
    self.baseNavigationItem.title = title;
}

- (void)setupNavigationBar {
    
    [self.view addSubview:self.baseNavigationBar];

    //将导航条目 添加到导航条
    self.baseNavigationBar.items = @[self.baseNavigationItem];
    //导航条的渲染颜色
    self.baseNavigationBar.barTintColor = [UIColor jp_colorWithHexString:@"F6F6F6"];
    //设置 bar 的标题字体颜色
    self.baseNavigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor purpleColor]};
    //设置系统的UIBarbuttonItem的字体颜色
    self.baseNavigationBar.tintColor = [UIColor purpleColor];

}

@end
