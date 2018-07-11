//
//  GDMapViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/23.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "GDMapViewController.h"
#import "GaodeBaseMapView.h"
#import "GaodeMapFactory.h"
#import "IMapEngine.h"

@interface GDMapViewController ()

@end

@implementation GDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"高德地图";
    
    [self jp_SetNavigationItemWithInfoString:@"tabbar_home" Type:JPNavigationItemType_Image Layout:YES FixSpace:YES target:self action:@selector(clickBtn)];


    //高德地图的初始化
//    id<IMapView> mapView = [[GaodeBaseMapView alloc] initWithFrame:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
//    [self.view addSubview:[mapView getView]];
    //工厂模式初始化
//    id<IMapFactory> mapFactory = [[GaodeMapFactory alloc] init];
//    id<IMapView> mapView = [mapFactory getMapView:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
//    [self.view addSubview:[mapView getView]];
    
    //使用引擎
    id<IMapFactory> mapFactory = [[IMapEngine sharedEngine] getMapFactoryType:SDKType_GD];
    id<IMapView> mapView = [mapFactory getMapView:CGRectMake(0, 64, self.view.jp_w, self.view.jp_h-64)];
    [self.view addSubview:[mapView getView]];

}

/** clickBtn */
- (void)clickBtn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
