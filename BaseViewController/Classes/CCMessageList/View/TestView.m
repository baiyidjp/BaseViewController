//
//  TestView.m
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "TestView.h"
#import "TestModel.h"
#import "TestDataModel.h"
#import "TestTableViewCell.h"
#import "TestViewModel.h"

@interface TestView ()<UITableViewDelegate,UITableViewDataSource>

/** tableview */
@property(nonatomic,strong) UITableView *tableView;
/** data */
@property(nonatomic,strong) NSArray *dataArray;


@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
        
        [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"TestTableViewCell"];
        
        [self addSubview:self.tableView];
        
    }
    return self;
}

- (void)testViewReloadDataWithData:(NSArray *)data {
    
    self.dataArray = data;
    
    [self.tableView reloadData];
}

#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestDataModel * dataModel = self.dataArray[indexPath.row];
    return dataModel.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestDataModel * dataModel = self.dataArray[indexPath.row];
    
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataModel = dataModel;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TestDataModel * dataModel = self.dataArray[indexPath.row];
    
    //通知viewmodel 点击事件传递
    [self.viewModel testViewDidSelectRowAtIndexPath:indexPath Model:dataModel.model];
    
}



@end
