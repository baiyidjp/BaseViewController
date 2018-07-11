//
//  FirstViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/3.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "FirstViewController.h"
#import "TestViewController.h"
#import "DynamicDemo.h"
#import "HiddenNavViewController.h"
#import "LoginViewController.h"
#import "MessageController.h"

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

    
//    JPNavigationController *nav = [[JPNavigationController alloc] initWithRootViewController:[LoginViewController new]];
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
