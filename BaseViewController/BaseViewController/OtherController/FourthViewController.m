//
//  FourthViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "FourthViewController.h"
#import "JPLoopView.h"
#import "MapViewController.h"

@interface FourthViewController ()<JPLoopViewDataSource,JPLoopViewDelegate>

@end

@implementation FourthViewController
{
    NSArray <NSString *>*_urls;
    JPLoopView *_loopView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _loopView = [[JPLoopView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.width*9.0/16)];
    _loopView.dataSource = self;
    _loopView.delegate = self;
    [self.view addSubview:_loopView];
    //先创建view后获取数据并reload
    [self loadData];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300+STATUS_BAR_HEIGHT, 100, 30)];
    [btn setTitle:@"换图" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(changePic) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"地图" fontSize:16 target:self action:@selector(clickBtn) isBack:NO];
    self.baseNavigationItem.rightBarButtonItem = rightItem;

}


- (void)loadData{
    
    _urls = @[@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/261147252661302_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/281001502516278_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg"];
    [_loopView jp_reloadData];
}

#pragma mark - 必须实现的代理
- (NSArray *)loopViewUrls:(JPLoopView *)loopView{
    
    return _urls;
}

#pragma mark - 可选择实现的代理
//- (CGRect)scrollViewFrame:(JPLoopView *)loopView{
//
//    return CGRectMake(10, 10, self.view.bounds.size.width-20, self.view.bounds.size.width*7.0/16);
//}
//
//- (CGRect)pageControlFrame:(JPLoopView *)loopView{
//
//    return CGRectMake(10, 10+self.view.bounds.size.width*7.0/16, self.view.bounds.size.width-20, self.view.bounds.size.width*2.0/16);
//}

//- (BOOL)hiddenPageControl:(JPLoopView *)loopView{
//
//    return YES;
//}

- (void)didSelectItem:(JPLoopView *)loopView index:(NSInteger)index{
    
    NSLog(@"select index -- %zd",index);
}


- (void)changePic {
    
    _urls = @[@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/261147252661302_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/281001502516278_480.jpg",@"http://ossweb-img.qq.com/upload/qqtalk/news/201610/201023267005533_480.jpg"];
    [_loopView jp_reloadData];
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
