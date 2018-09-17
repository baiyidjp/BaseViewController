//
//  FourthViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "FourthViewController.h"
#import "JPLoopViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self jp_HiddenNavigationBarAndShowBackBtn:NO];

    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100+STATUS_BAR_HEIGHT, 100, 30)];
    [nextBtn setTitle:@"轮播图示例" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark -nextClick
- (void)nextClick {
    
    [self.navigationController pushViewController:[[JPLoopViewController alloc] init] animated:YES];
}


@end
