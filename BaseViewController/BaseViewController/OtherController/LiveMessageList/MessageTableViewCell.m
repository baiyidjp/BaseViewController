//
//  MessageTableViewCell.m
//  BaseViewController
//
//  Created by baiyi on 2018/7/5.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageViewModel.h"
#import "UIColor+JP_Color.h"

@implementation MessageTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = RGBAColor(28, 34, 38, 0.6);
        [self.contentView addSubview:backView];
        self.backView = backView;

        self.contentLabel = [[YYLabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)setViewModel:(MessageViewModel *)viewModel {
    
    _viewModel = viewModel;
    
    self.contentLabel.attributedText = viewModel.attributedText;
    self.contentLabel.frame = viewModel.contentFrame;
    
    self.backView.frame = viewModel.bgViewFrame;
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
}

@end
