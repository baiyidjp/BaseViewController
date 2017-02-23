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

@interface FirstViewController ()

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
}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[TestViewController alloc] init] animated:YES];
}


@end
