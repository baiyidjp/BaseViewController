//
//  MainTabBarController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController
{
    UIButton        *_customButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    //设置自定义的按钮 不需要可注释
    [self setupCustomButton];
}

/**
 创建子控制器

 @param dict 导航控制器的根控制器的数据
 @return 一个导航控制器
 */
- (UIViewController *)setupChildController:(NSDictionary *)dict {
    
    //通过反射机制拿到对应的控制器
    Class controllerClass = NSClassFromString(dict[@"className"]);
    BaseViewController *controller = [[controllerClass alloc] init];
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
    
    BaseNavigationController *navCtrl = [[BaseNavigationController alloc] initWithRootViewController:controller];
    return navCtrl;
}

//通过代理 设置点击item 的动画效果
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

- (void)setupCustomButton {
    
    //基本属性
    _customButton = [[UIButton alloc] init];
    [_customButton setBackgroundColor:[UIColor greenColor]];
    [_customButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [_customButton setTitle:@"董" forState:UIControlStateNormal];
    
    [self.tabBar addSubview:_customButton];
    
    //子控制器个数
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = self.tabBar.bounds.size.width / count;
    
    _customButton.frame = CGRectMake((count/2)*btnW, 0, btnW, self.tabBar.bounds.size.height);
    _customButton.layer.cornerRadius = 5;
    [_customButton addTarget:self action:@selector(clickCustomBtn) forControlEvents:UIControlEventTouchUpInside];

}
- (void)clickCustomBtn {
    
    NSLog(@"clickCustomBtn");
}

@end
