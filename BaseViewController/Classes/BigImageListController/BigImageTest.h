//
//  BigImageTest.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/17.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPBaseViewController.h"

@interface BigImageTest : JPBaseViewController<UITableViewDataSource,UITableViewDelegate>
/** table */
@property(nonatomic,strong) UITableView *tableView;

@end
