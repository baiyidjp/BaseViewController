//
//  TestViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "TestViewController.h"
#import "LoadingHUD.h"

@interface TestViewController ()

@end

@implementation TestViewController
{
    NSMutableArray *_dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Test";
    
    [self setupTableViewWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    
    
    
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSString *str = [NSString stringWithFormat:@"死数据--%d",i];
        [_dataArray addObject:str];
    }
    
}

- (void)setupTableViewWithFrame:(CGRect)frame {
    
    [super setupTableViewWithFrame:frame];
    
    [self.baseTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击--%zd",indexPath.row);
    [LoadingHUD showHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LoadingHUD dismissHUD];
    });
}

- (void)loadNewData {
    
    [_dataArray insertObject:@"下拉--新数据" atIndex:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.baseTableView reloadData];
        [self loadNewEndRefresh];
        if (_dataArray.count > 25) {
            [self noMoreData];
        }
    });
}

- (void)loadMoreData {
    
    [_dataArray addObject:@"上拉--新数据"];
    NSLog(@"1");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.baseTableView reloadData];
        if (_dataArray.count > 25) {
            [self noMoreData];
        }else {
            [self loadMoreEndRefresh];
        }
    });

}

@end
