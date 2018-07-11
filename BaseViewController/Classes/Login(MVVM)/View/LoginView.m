//
//  LoginView.m
//  BaseViewController
//
//  Created by baiyi on 2018/6/22.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "LoginView.h"
#import "LoginViewModel.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_SetUI];
    }
    return self;
}

#pragma mark -设置UI
- (void)p_SetUI {
    
    UITextField *userNameText = [[UITextField alloc] initWithFrame:CGRectMake(15, STATUS_BAR_HEIGHT + 20, KScreenWidth - 30, 44)];
    userNameText.placeholder = @"输入账号...";
    userNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameText.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:userNameText];
    self.userNameText = userNameText;
    
    UITextField *passWordText = [[UITextField alloc] initWithFrame:CGRectMake(15, STATUS_BAR_HEIGHT + 20 + 44 + 15, KScreenWidth - 30, 44)];
    passWordText.placeholder = @"输入密码...";
    passWordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWordText.borderStyle = UITextBorderStyleRoundedRect;
    passWordText.secureTextEntry = YES;
    [self addSubview:passWordText];
    self.passWordText = passWordText;
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.5 - 30, CGRectGetMaxY(passWordText.frame)+ 15, 60, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor purpleColor]];
    [loginBtn addTarget:self action:@selector(p_ClickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginBtn];
    
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.5 - 50, CGRectGetMaxY(loginBtn.frame)+ 15, 100, 40)];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setBackgroundColor:[UIColor purpleColor]];
    [forgetBtn addTarget:self action:@selector(p_ClickForgetBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetBtn];

}

#pragma mark -点击登陆
- (void)p_ClickLoginBtn {
    
    [self.loginViewModel loginClick];
}

#pragma mark -点击忘记密码
- (void)p_ClickForgetBtn {
    
    [self.loginViewModel forgetClick];
}


- (void)setLoginViewModel:(LoginViewModel *)loginViewModel {
    
    _loginViewModel = loginViewModel;
    
    loginViewModel.userNameText = self.userNameText;
    loginViewModel.passWordText = self.passWordText;
}

@end
