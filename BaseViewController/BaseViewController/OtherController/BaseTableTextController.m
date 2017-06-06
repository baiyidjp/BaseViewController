//
//  BaseTableTextController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/28.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BaseTableTextController.h"
#import "BaseTableView.h"

@interface BaseTableTextController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate>

@property(nonatomic,weak) BaseTableView *tableView;

@end

@implementation BaseTableTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"BaseTableTextController";
    
    BaseTableView *tableView = [BaseTableView BaseTableViewWithFrame:CGRectMake(0, 100, 300, 300) Style:UITableViewStylePlain Refresh:YES];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.baseTableViewDelegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = NO;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"111"];
    cell.textLabel.text = @"baseTableCell";
    return cell;
}

- (void)tableViewRefreshNewData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView stopRefresh];
    });
    
}

- (void)tableViewRefreshMoreData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView stopRefreshWithNoMoreData];
    });

}

@end
