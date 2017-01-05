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

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" fontSize:16 target:self action:@selector(clickBtn) isBack:NO];
    self.baseNavigationItem.rightBarButtonItem = rightItem;
    
}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[TestViewController alloc] init] animated:YES];
}


@end
