//
//  BigImageTest.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/17.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "BigImageTest.h"
#import "BigImageViewController.h"

@implementation BigImageTest

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"加载大图-卡";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, self.view.bounds.size.width, self.view.bounds.size.height-NavHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [self jp_SetNavigationRightTextItemWithInfoString:@"优化" target:self action:@selector(clickBtn)];
    
}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[BigImageViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell.contentView.subviews.count) {
        [cell.contentView jp_removeAllSubViews];
    }
    
    [self addLabel:cell];
    
    [self addImage1:cell];
    [self addImage2:cell];
    [self addImage3:cell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (void)addLabel:(UITableViewCell *)cell {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 300, 30)];
    label.text = @"加载大图测试-点击优化体验顺畅";
    [cell.contentView addSubview:label];
}

/** addimage */
- (void)addImage1:(UITableViewCell *)cell {
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 120, 60)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"曼巴谢幕" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imv.contentMode = UIViewContentModeScaleAspectFit;
    imv.image = image;

    [cell.contentView addSubview:imv];
}
- (void)addImage2:(UITableViewCell *)cell {
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(125, 40, 120, 60)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"曼巴谢幕" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imv.contentMode = UIViewContentModeScaleAspectFit;
    imv.image = image;
    [cell.contentView addSubview:imv];
}
- (void)addImage3:(UITableViewCell *)cell {
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(250, 40, 120, 60)];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"曼巴谢幕" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    imv.contentMode = UIViewContentModeScaleAspectFit;
    imv.image = image;
    [cell.contentView addSubview:imv];
}

@end
