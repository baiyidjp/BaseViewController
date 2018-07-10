//
//  LoginView.h
//  BaseViewController
//
//  Created by baiyi on 2018/6/22.
//  Copyright © 2018年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewModel;
@interface LoginView : UIView

/** viewmodel */
@property(nonatomic,strong) LoginViewModel *loginViewModel;
/** textfiled */
@property(nonatomic,strong) UITextField *userNameText;
/** pass */
@property(nonatomic,strong) UITextField *passWordText;


@end
