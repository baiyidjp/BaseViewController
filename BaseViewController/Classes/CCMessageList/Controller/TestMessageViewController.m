//
//  TestViewController.m
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "TestMessageViewController.h"
#import "TestViewModel.h"
#import "TestView.h"

@interface TestMessageViewController ()
/** viewmodel */
@property(nonatomic,strong) TestViewModel *viewModel;
/** listview */
@property(nonatomic,strong) TestView *testView;
@end

@implementation TestMessageViewController

- (TestView *)testView{
    
    if (!_testView) {
        
        _testView = [[TestView alloc] initWithFrame:CGRectMake(0, NavHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-NavHeight)];
    }
    return _testView;
}

- (TestViewModel *)viewModel{
    
    if (!_viewModel) {
        
        _viewModel = [[TestViewModel alloc] initWithController:self];;
    }
    return _viewModel;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MessageListDemo";
    
    [self.view addSubview:self.testView];
    
    //双向绑定
    self.testView.viewModel = self.viewModel;
    self.viewModel.testView = self.testView;
    
    //数据请求
    [self.viewModel requestData];
    
}

@end
