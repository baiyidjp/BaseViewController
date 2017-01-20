//
//  BaseNavigationController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setHidden:YES];
}

//重写父类的跳转
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //创建BaseNavigationController实例的时候 会先走这个方法 此时子控制器为0
    //当子控制器的个数大于0 便是进入了第二级页面
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        NSString *backTitle = @"返回";
        //通过分类获取自定义的item
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:backTitle fontSize:16 target:self action:@selector(popViewController) isBack:YES];
        //为了向左缩进
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceItem.width = -10;
        
        BaseViewController *baseCtrl = (BaseViewController *)viewController;
        baseCtrl.baseNavigationItem.leftBarButtonItems = @[spaceItem,backItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popViewController {
    
    [self popViewControllerAnimated:YES];
}

@end
