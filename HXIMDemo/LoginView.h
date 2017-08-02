//
//  LoginView.h
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginView : UIView

/**
 账号
 */
@property (strong, nonatomic) IBOutlet UITextField *cardTextField;

/**
 密码
 */
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;


+(instancetype)initWithLoginViewFrame:(CGRect)frame cardText:(NSString *)cardString password:(NSString *)passwordString cardPlaceholder:(NSString *)cardPlaceholder passwordPlaceholder:(NSString *)passwordPlaceholder;

@end
