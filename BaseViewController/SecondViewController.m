//
//  SecondViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "SecondViewController.h"
#import "UIImage+Extension.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    [self.view addSubview:imageView];
    UIImage *image = [UIImage imageNamed:@"曼巴谢幕"];
    [image jp_asynCornerImageWithSize:imageView.bounds.size cornerRadius:15 fillColor:self.view.backgroundColor completion:^(UIImage *image) {
        imageView.image = image;
    }];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
    [self.view addSubview:imageView1];
    imageView1.image = [image jp_cornerImageWithSize:imageView1.bounds.size fillColor:self.view.backgroundColor];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 400, 150, 100)];
    [self.view addSubview:imageView2];
    imageView2.image = [image jp_cornerImageWithSize:imageView2.bounds.size cornerRadius:0 fillColor:self.view.backgroundColor];
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
