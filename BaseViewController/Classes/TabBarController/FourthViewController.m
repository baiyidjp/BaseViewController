//
//  FourthViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "FourthViewController.h"
#import "JPLoopView.h"
#import "JPLoopViewController.h"

@interface FourthViewController ()<JPLoopViewDelegate>

@end

@implementation FourthViewController
{
    NSArray <NSString *>*_urls;
    JPLoopView *_loopView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self jp_HiddenNavigationBarAndShowBackBtn:NO];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300+STATUS_BAR_HEIGHT, 100, 30)];
    [btn setTitle:@"换图" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(changePic) forControlEvents:UIControlEventTouchUpInside];
    
    _loopView = [JPLoopView loopViewWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.width*9.0/16) delegate:self placeholderImage:nil];
    [self.view addSubview:_loopView];
    
    NSArray *images = @[@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/261147252661302_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/281001502516278_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg"];
    
    [_loopView setLoopImageArray:images];
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400+STATUS_BAR_HEIGHT, 100, 30)];
    [nextBtn setTitle:@"下一级" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didSelectItem:(JPLoopView *)loopView index:(NSInteger)index{
    
    NSLog(@"select index -- %zd",index);
}


- (void)changePic {
    
    NSArray *images = @[@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/281001502516278_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/261147252661302_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg"];

    [_loopView setLoopImageArray:images];
}

#pragma mark -nextClick
- (void)nextClick {
    
    [self.navigationController pushViewController:[[JPLoopViewController alloc] init] animated:YES];
}


@end
