//
//  JPNavigationController.m
//  JPNavigationDemo
//
//  Created by baiyi on 2018/7/10.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "JPNavigationController.h"

@interface JPNavigationController ()

@end

@implementation JPNavigationController

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
        
        JPBaseViewController *baseCtrl = (JPBaseViewController *)viewController;
        [baseCtrl jp_SetNavigationBackItemWithTarget:self action:@selector(p_ClickBackBtn)];
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)p_ClickBackBtn {
    
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
