//
//  LoginManager.m
//  BaseViewController
//
//  Created by baiyi on 2018/6/22.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager

+ (instancetype)sharedManager {
    
    static LoginManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[LoginManager alloc] init];
    });
    
    return manager;
}

- (void)clearLoginInfo {
    
    self.username = nil;
}

@end
