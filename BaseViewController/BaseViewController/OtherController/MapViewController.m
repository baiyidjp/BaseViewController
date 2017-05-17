//
//  MapViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "MapViewController.h"
#import "BaiduBaseMapView.h"
#import "GDMapViewController.h"
#import "BaiduMapFactory.h"
#import "IMapEngine.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"弹出视图";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" fontSize:16 target:self action:@selector(clickBtn) isBack:NO];
    self.baseNavigationItem.leftBarButtonItem = leftItem;
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"高德" fontSize:16 target:self action:@selector(clickRightBtn) isBack:NO];
//    self.baseNavigationItem.rightBarButtonItem = rightItem;

    
    //初始化百度地图
//     id<IMapView> mapView = [[BaiduBaseMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
//    [self.view addSubview:[mapView getView]];
    
    //使用工厂模式初始化
//    id<IMapFactory> mapFactory = [[BaiduMapFactory alloc] init];
//    id<IMapView> mapView = [mapFactory getMapView:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
//    [self.view addSubview:[mapView getView]];
    //使用引擎
//    id<IMapFactory> mapFactory = [[IMapEngine sharedEngine] getMapFactoryType:SDKType_BD];
//    id<IMapView> mapView = [mapFactory getMapView:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
//    [self.view addSubview:[mapView getView]];

}

/** clickBtn */
- (void)clickBtn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** clickRightBtn */
- (void)clickRightBtn {
    
    [self presentViewController:[GDMapViewController new]  animated:YES completion:nil];
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
