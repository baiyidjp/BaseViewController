//
//  BaseTableTextController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/28.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaseTableTextController.h"
#import "BaseTableView.h"

@interface BaseTableTextController ()<BaseTableViewDelegate>

@end

@implementation BaseTableTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    BaseTableView *tableView = [[BaseTableView alloc] initWithFrame:self.view.bounds];
    tableView.baseTableViewDelegate = self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
    return cell;
}
@end
