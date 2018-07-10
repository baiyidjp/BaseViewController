//
//  MessageViewModel.h
//  BaseViewController
//
//  Created by baiyi on 2018/7/5.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageModel;

@protocol MessageViewModelDelegate<NSObject>

- (void)viewModelDidSelectedRankWithModel:(MessageModel *)model;

- (void)viewModelDidSelectedNameWithModel:(MessageModel *)model;

@end

@interface MessageViewModel : NSObject

@property(nonatomic,weak)id<MessageViewModelDelegate> delegate;

/** model */
@property(nonatomic,strong) MessageModel *model;

/** attributedText */
@property(nonatomic,strong) NSMutableAttributedString *attributedText;

/** labelframe */
@property(nonatomic,assign) CGRect contentFrame;

/** bgframe */
@property(nonatomic,assign) CGRect bgViewFrame;

/** cellh */
@property(nonatomic,assign) CGFloat cellHeight;


@end
