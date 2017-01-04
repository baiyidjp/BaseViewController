//
//  BaseViewController.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/3.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/** tableView */
@property(nonatomic,strong)UITableView *tableView;

/** 自定义导航栏 */
@property(nonatomic,strong) UINavigationBar *baseNavigationBar;

/** 自定义导航条目 */
@property(nonatomic,strong) UINavigationItem *baseNavigationItem;


@end
