//
//  MessageModel.h
//  BaseViewController
//
//  Created by baiyi on 2018/7/5.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

/** rank */
@property(nonatomic,copy)NSString *rank;
/** name */
@property(nonatomic,copy)NSString *name;
/** text */
@property(nonatomic,copy)NSString *content;

@end
