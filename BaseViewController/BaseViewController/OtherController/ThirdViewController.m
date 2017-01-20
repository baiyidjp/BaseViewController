//
//  ThirdViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ThirdViewController.h"
#import "UIImageView+SDWebImage.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *L = [[UILabel alloc] initWithFrame:CGRectMake(50, 70, 300, 20)];
    L.text = @"UIImageView+SDWebImage";
    [self.view addSubview:L];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    [self.view addSubview:imageView];
    UIImage *image = [UIImage imageNamed:@"曼巴谢幕"];
    [imageView jp_setSDImageWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/forum/pic/item/e4210760fc19c67cb9998f60.jpg"] placeholderImage:image];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
    [self.view addSubview:imageView1];
    [imageView1 jp_setSDCornerImageWithURL:[NSURL URLWithString:@"http://image.bitauto.com/dealer/news/100074966/2a6cf934-f0c4-46b2-940e-c7cced949b4e.jpg"] placeholderImage:image];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 400, 150, 100)];
    [self.view addSubview:imageView2];
    [imageView2 jp_setSDImageWithURL:[NSURL URLWithString:@"http://a.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0e7551694ded2e73fcbc8e28b2318dbd/4610b912c8fcc3cefbf277de9545d688d43f2028.jpg"] placeholderImage:image cornerRadius:10];

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
