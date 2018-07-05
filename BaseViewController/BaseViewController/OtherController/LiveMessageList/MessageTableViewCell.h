//
//  MessageTableViewCell.h
//  BaseViewController
//
//  Created by baiyi on 2018/7/5.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYText/YYText.h"

@class MessageViewModel;
@interface MessageTableViewCell : UITableViewCell

/** viewmodel */
@property(nonatomic,strong) MessageViewModel *viewModel;

/** label */
@property(nonatomic,strong) YYLabel *contentLabel;

@property(nonatomic,strong) UIView *backView;

@end
