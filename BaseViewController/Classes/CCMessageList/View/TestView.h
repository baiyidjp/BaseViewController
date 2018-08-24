//
//  TestView.h
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestViewModel;
@interface TestView : UIView

/** viewmodel */
@property(nonatomic,strong) TestViewModel *viewModel;

/**
 更新数据

 @param data 数据
 */
- (void)testViewReloadDataWithData:(NSArray *)data;

@end
