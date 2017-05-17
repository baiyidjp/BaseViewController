//
//  BaseTableView.h
//  BaseViewController
//
//  Created by Keep丶Dream on 17/2/28.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseTableViewDelegate <NSObject,UITableViewDelegate,UITableViewDataSource>


@end

@interface BaseTableView : UITableView

@property(nonatomic,weak)id<BaseTableViewDelegate> baseTableViewDelegate;

@end
