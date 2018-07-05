//
//  FirstViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/3.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "FirstViewController.h"
#import "TestViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "DynamicDemo.h"
#import "BaseTableView.h"
#import "HiddenNavViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "MessageController.h"

@interface FirstViewController ()<BaseTableViewDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" fontSize:16 target:self action:@selector(clickBtn) isBack:NO];
    self.baseNavigationItem.rightBarButtonItem = rightItem;

    DynamicDemo *dynamic = [[DynamicDemo alloc] init];
    dynamic.date = [NSDate date];
    dynamic.string = @"I am string";
    dynamic.objc = [[UIView alloc] init];
    NSLog(@"date:%@\nstring:%@\nobj:%@",dynamic.date,dynamic.string,dynamic.objc);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 100, 40)];
    [btn setTitle:@"MsgList" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickDian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[LoginViewController new]];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[TestViewController alloc] init] animated:YES];
}

- (void)clickDian {
    
    MessageController *msgCtrl = [[MessageController alloc] init];
    [self.navigationController pushViewController:msgCtrl animated:YES];
}

@end
