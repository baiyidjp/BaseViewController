//
//  HiddenNavViewController.m
//  BaseViewController
//
//  Created by baiyi on 2018/4/20.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "HiddenNavViewController.h"

@interface HiddenNavViewController ()

@end

@implementation HiddenNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 20, 40)];
    [btn setImage:[UIImage imageNamed:@"navigationbar_back_withtext"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickDian) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -clickDian
- (void)clickDian {
    
    [self.navigationController popViewControllerAnimated:YES];
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
