//
//  LoginViewModel.h
//  BaseViewController
//
//  Created by baiyi on 2018/6/22.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginViewModelDelegate<NSObject>

/**
 点击登录按钮 
 */
- (void)loginViewModelDidSelectedLoginBtn;
/**
 点击忘记密码
 */
- (void)loginViewModelDidSelectedForgetBtn;
@end

@interface LoginViewModel : NSObject

/** textfiled */
@property(nonatomic,strong) UITextField *userNameText;
/** pass */
@property(nonatomic,strong) UITextField *passWordText;
/** controller */
@property(nonatomic,strong) UIViewController *ctrl;

@property(nonatomic,weak)id<LoginViewModelDelegate> delegate;

/** 登陆 */
- (void)loginClick;
/** 忘记密码 */
- (void)forgetClick;

@end
