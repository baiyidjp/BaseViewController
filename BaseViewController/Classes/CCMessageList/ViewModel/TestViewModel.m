//
//  TestViewModel.m
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "TestViewModel.h"
#import "TestModel.h"
#import "TestDataModel.h"
#import "YYModel.h"
#import "TestView.h"

@interface TestViewModel ()

/** controller */
@property(nonatomic,strong) UIViewController *controller;
/** data */
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation TestViewModel

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (instancetype)initWithController:(UIViewController *)controller {
    
    self = [super init];
    if (self) {
        
        self.controller = controller;
        
    }
    return self;

}

- (void)requestData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (id dict in dataArray) {
        
        TestModel * model = [TestModel yy_modelWithJSON:dict];
        TestDataModel *dataModel = [[TestDataModel alloc] init];
        dataModel.model = model;
        [self.dataArray addObject:dataModel];
    }
    
    //通知view 更新数据
    [self.testView testViewReloadDataWithData:[self.dataArray copy]];
}

- (void)testViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath Model:(TestModel *)model {
    
    NSLog(@"点击第%zd行",indexPath.row);
}

@end
