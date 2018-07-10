//
//  LoginViewController.m
//  BaseViewController
//
//  Created by baiyi on 2018/6/22.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "LoginViewModel.h"
#import "LoginManager.h"
#import "ForgetViewController.h"

@interface LoginViewController ()<LoginViewModelDelegate>
/** view */
@property(nonatomic,strong) LoginView *loginView;
/** viewmodel */
@property(nonatomic,strong) LoginViewModel *loginViewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isHiddenNavigationBar = YES;
    
    [self p_SetUI];
}

- (LoginView *)loginView{
    
    if (!_loginView) {
        
        _loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    }
    return _loginView;
}

- (LoginViewModel *)loginViewModel{
    
    if (!_loginViewModel) {
        
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

#pragma mark -设置UI
- (void)p_SetUI {
    
    [self.view addSubview:self.loginView];
    
    self.loginView.loginViewModel = self.loginViewModel;
    
    self.loginViewModel.delegate = self;
}

#pragma mark - LoginViewModelDelegate
- (void)loginViewModelDidSelectedLoginBtn {
    
    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    LoginManager *loginManager = [LoginManager sharedManager];
    //使用单例保存登陆所拿到的所有数据 用户名/密码/头像/手机号....
    //以便 其他模块可以直接使用
    //退出登陆可以直接 将所有值全部清空
    loginManager.username = @"用户名";
}

- (void)loginViewModelDidSelectedForgetBtn {
    
    [self.navigationController pushViewController:[ForgetViewController new] animated:YES];
}

@end
