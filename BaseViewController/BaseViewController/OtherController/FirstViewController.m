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
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn setTitle:@"点" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickDian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[TestViewController alloc] init] animated:YES];
}

- (void)clickDian {
    
    HiddenNavViewController *fourCtrl = [[HiddenNavViewController alloc] init];
    [self.navigationController pushViewController:fourCtrl animated:YES];
}

@end
