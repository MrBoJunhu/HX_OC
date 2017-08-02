//
//  LoginView.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "LoginView.h"

@interface LoginView()


@end

@implementation LoginView

+(instancetype)initWithLoginViewFrame:(CGRect)frame cardText:(NSString *)cardString password:(NSString *)passwordString cardPlaceholder:(NSString *)cardPlaceholder passwordPlaceholder:(NSString *)passwordPlaceholder {
   
    LoginView *loginV = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    
    loginV.frame = frame;
    
    loginV.cardTextField.text = cardString;
    
    loginV.cardTextField.placeholder = cardPlaceholder;
    
    loginV.passwordTextField.text = passwordString;
    
    loginV.passwordTextField.placeholder = passwordPlaceholder;
    
    return loginV;
    
}

@end
