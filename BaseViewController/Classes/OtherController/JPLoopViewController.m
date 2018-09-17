//
//  JPLoopViewController.m
//  BaseViewController
//
//  Created by baiyi on 2018/9/16.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "JPLoopViewController.h"
#import "JPLoopView.h"

@interface JPLoopViewController ()<JPLoopViewDelegate>
/** loopView; */
@property(nonatomic,strong) JPLoopView *loopView;
@property(nonatomic,strong) JPLoopView *loopView_1;
@end

@implementation JPLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轮播图";
    
    self.loopView = [JPLoopView loopViewWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.width*9.0/16) delegate:self placeholderImage:nil];
    self.loopView.pageIndicatorTintColor = [UIColor whiteColor];
    self.loopView.pageIndicatorImage = [UIImage imageNamed:@"home_new_bannerDotImage"];
    self.loopView.currentPageIndicatorImage = [UIImage imageNamed:@"home_new_bannerCurrentImage"];
    self.loopView.pageIndicatorSize = CGSizeMake(7, 2);
    self.loopView.intervalTime = 5;
    self.loopView.pageControlAliment = JPLoopViewPageControlAlimentRight;
    [self.view addSubview:self.loopView];
    
    NSArray *images = @[@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/261147252661302_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/281001502516278_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg"];
    
    [self.loopView setLoopImageArray:images];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300+STATUS_BAR_HEIGHT, 100, 30)];
    [btn setTitle:@"换图" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(changePic) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.loopView_1 = [JPLoopView loopViewWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)+20, self.view.bounds.size.width, self.view.bounds.size.width*9.0/16) delegate:self placeholderImage:nil];
    self.loopView_1.pageIndicatorTintColor = [UIColor whiteColor];
    self.loopView_1.intervalTime = 10;
    self.loopView_1.pageControlAliment = JPLoopViewPageControlAlimentLeft;
    [self.view addSubview:self.loopView_1];
    
    NSArray *images_1 = @[@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/261147252661302_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/281001502516278_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg"];
    
    [self.loopView_1 setLoopImageArray:images_1 loopTitleArray:@[@"0000000000",@"1111111111",@"2222222222"]];


}

- (void)didSelectItem:(JPLoopView *)loopView index:(NSInteger)index{
    
    NSLog(@"select index -- %zd",index);
}


- (void)changePic {
    
    NSArray *images = @[@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/281001502516278_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/261147252661302_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg"];
    [self.loopView setLoopImageArray:images loopTitleArray:@[@"0000000000",@"1111111111",@"2222222222",@"3333333333"]];
}


@end
