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
#import "UIImage+Extension.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" fontSize:16 target:self action:@selector(clickBtn) isBack:NO];
    self.baseNavigationItem.rightBarButtonItem = rightItem;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    [self.view addSubview:imageView];
    UIImage *image = [UIImage imageNamed:@"曼巴谢幕"];
    [image jp_cornerImageWithSize:imageView.bounds.size corner:15 fillColor:self.view.backgroundColor completion:^(UIImage *image) {
        imageView.image = image;
    }];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
    [self.view addSubview:imageView1];
    [image jp_cornerImageWithSize:imageView1.bounds.size fillColor:self.view.backgroundColor completion:^(UIImage *image) {
        imageView1.image = image;
    }];
}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[TestViewController alloc] init] animated:YES];
}


@end
