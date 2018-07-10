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
    
    self.title = @"PresendViewController";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithItemImageName:@"tabbar_home" Layout:YES target:self action:@selector(p_ClickBackBtn)];
    self.jp_NavigationItem.leftBarButtonItem = backItem;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithItemTitle:@"高德Map" Layout:NO target:self action:@selector(p_ClickRightBtn)];
    self.jp_NavigationItem.rightBarButtonItem = rightItem;


    
    //初始化百度地图
//     id<IMapView> mapView = [[BaiduBaseMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
//    [self.view addSubview:[mapView getView]];
    
    //使用工厂模式初始化
//    id<IMapFactory> mapFactory = [[BaiduMapFactory alloc] init];
//    id<IMapView> mapView = [mapFactory getMapView:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
//    [self.view addSubview:[mapView getView]];
    //使用引擎
    id<IMapFactory> mapFactory = [[IMapEngine sharedEngine] getMapFactoryType:SDKType_BD];
    id<IMapView> mapView = [mapFactory getMapView:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
    [self.view addSubview:[mapView getView]];

}

/** clickBtn */
- (void)p_ClickBackBtn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** clickRightBtn */
- (void)p_ClickRightBtn {
    
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
