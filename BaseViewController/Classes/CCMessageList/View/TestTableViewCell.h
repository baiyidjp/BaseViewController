//
//  TestTableViewCell.h
//  test
//
//  Created by baiyi on 2018/7/30.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestDataModel;
@interface TestTableViewCell : UITableViewCell

/** datamodel */
@property(nonatomic,strong) TestDataModel *dataModel;

@end
