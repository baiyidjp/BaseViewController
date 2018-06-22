//
//  LoginManager.h
//  BaseViewController
//
//  Created by baiyi on 2018/6/22.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManager : NSObject

+ (instancetype)sharedManager;

/**
 清空登陆保存的数据
 */
- (void)clearLoginInfo;

/** username */
@property(nonatomic,copy)NSString *username;

@end
