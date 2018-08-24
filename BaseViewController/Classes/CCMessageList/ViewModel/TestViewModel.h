//
//  TestViewModel.h
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TestModel,TestView;
@interface TestViewModel : NSObject

/** listview */
@property(nonatomic,strong) TestView *testView;

/**
 数据请求
 */
- (void)requestData;

/**
 子类实现构造方法
 
 @param controller 当前控制器
 @return viewModel
 */
- (instancetype)initWithController:(UIViewController *)controller;

/** 点击cell */
- (void)testViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath Model:(TestModel *)model;


@end
