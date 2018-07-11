//
//  MainTabBarController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "MainTabBarController.h"
#import "JPNavigationController.h"
#import "JPBaseViewController.h"
#import "JPTabBar.h"
#import "MapViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self p_SetCustomTabBar];
    
    //获取plist数据
    NSString *infoPath = [[NSBundle mainBundle] pathForResource:@"MainControllerInfo.plist" ofType:nil];
    NSArray *infoArray = [NSArray arrayWithContentsOfFile:infoPath];
    /*
     {
     className = FirstViewController; //子控制器名
     classTitle = First;//tabBar名
     imageName = home;//图片名
     }
     */
    //创建一个控制器集合
    NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:infoArray.count];
    for (NSDictionary *dict in infoArray) {
        [controllers addObject:[self setupChildController:dict]];
    }
    //设置子控制器
    self.viewControllers = controllers;
    
}

/**
 创建子控制器

 @param dict 导航控制器的根控制器的数据
 @return 一个导航控制器
 */
- (UIViewController *)setupChildController:(NSDictionary *)dict {
    
    //通过反射机制拿到对应的控制器
    Class controllerClass = NSClassFromString(dict[@"className"]);
    JPBaseViewController *controller = [[controllerClass alloc] init];
    //取出标题和图片名
    NSString *title = dict[@"classTitle"] ?  dict[@"classTitle"] : @"";
    NSString *imageName = dict[@"imageName"] ? [NSString stringWithFormat:@"tabbar_%@",dict[@"imageName"]] : @"";
    NSString *selectImageName = [NSString stringWithFormat:@"%@_selected",imageName];
    //设置控制器所需数据
    controller.title = title;
    controller.tabBarItem.title = title;
    //设置标题的图片--Normal/Selected
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置标题文字的颜色--Normal/Selected
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    
    JPNavigationController *navCtrl = [[JPNavigationController alloc] initWithRootViewController:controller];
    return navCtrl;
}

#pragma mark -设置tabBar
- (void)p_SetCustomTabBar {
    
    JPTabBar *baseTabBar = [[JPTabBar alloc] initWithFrame:self.tabBar.frame ShowCustom:YES];
    
    [self setValue:baseTabBar forKey:@"tabBar"];
    
    [baseTabBar setCustomBtnClick:^(UIButton *customBtn) {
        [self clickCustomBtn];
    }];
}


- (void)clickCustomBtn {
    
    [self presentViewController:[MapViewController new] animated:YES completion:nil];
}

//判断是否重复点了哪个item
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}

@end
