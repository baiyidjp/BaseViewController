//
//  FirstViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/3.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "FirstViewController.h"
#import "TestMessageViewController.h"
#import "DynamicDemo.h"
#import "HiddenNavViewController.h"
#import "LoginViewController.h"
#import "MessageController.h"
#import "NextViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self jp_SetNavigationRightTextItemWithInfoString:@"Next" target:self action:@selector(clickBtn)];
    
    [self jp_SetNavigationItemWithInfoString:@"MsgList" Type:JPNavigationItemType_Text Layout:YES FixSpace:YES target:self action:@selector(clickDian)];
    
    DynamicDemo *dynamic = [[DynamicDemo alloc] init];
    dynamic.date = [NSDate date];
    dynamic.string = @"I am string";
    dynamic.objc = [[UIView alloc] init];
    NSLog(@"date:%@\nstring:%@\nobj:%@",dynamic.date,dynamic.string,dynamic.objc);
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300+STATUS_BAR_HEIGHT, 100, 30)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(p_ClickLoginBtn) forControlEvents:UIControlEventTouchUpInside];

    UIButton *messageBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300+STATUS_BAR_HEIGHT+50, 100, 30)];
    [messageBtn setTitle:@"信息流" forState:UIControlStateNormal];
    [messageBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:messageBtn];
    [messageBtn addTarget:self action:@selector(p_ClickMessageBtn) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark -denglu
- (void)p_ClickLoginBtn {
    
    JPNavigationController *nav = [[JPNavigationController alloc] initWithRootViewController:[LoginViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -message
- (void)p_ClickMessageBtn {
    
    [self.navigationController pushViewController:[[TestMessageViewController alloc] init] animated:YES];

}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[NextViewController alloc] init] animated:YES];
}

- (void)clickDian {
    
    MessageController *msgCtrl = [[MessageController alloc] init];
    [self.navigationController pushViewController:msgCtrl animated:YES];
}

@end
