//
//  LoginViewModel.m
//  BaseViewController
//
//  Created by baiyi on 2018/6/22.
//  Copyright © 2018年 dong. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (void)loginClick {
    
    if (!self.userNameText.text.length) {
        
        [SVProgressHUD showErrorWithStatus:@"账号不可为空"];
        return;
    }
    
    if (!self.passWordText.text.length) {
        
        [SVProgressHUD showErrorWithStatus:@"密码不可为空"];
        return;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(loginViewModelDidSelectedLoginBtn)]) {
        [self.delegate loginViewModelDidSelectedLoginBtn];
    }
}

- (void)forgetClick {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginViewModelDidSelectedForgetBtn)]) {
        [self.delegate loginViewModelDidSelectedForgetBtn];
    }

}

@end
