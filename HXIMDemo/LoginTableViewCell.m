//
//  LoginTableViewCell.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "LoginTableViewCell.h"
#import "LoginView.h"
@interface LoginTableViewCell()

@property (strong, nonatomic) IBOutlet UIView *tempView;

@property (nonatomic, strong) LoginView *loginV;

@property (nonatomic, copy) clickRegistButtonBlock registBlock;

@property (nonatomic, copy) clickLoginButtonBlock loginBlock;

@end

@implementation LoginTableViewCell

- (void)awakeFromNib {
   
    [super awakeFromNib];
    
    self.loginV = [LoginView initWithLoginViewFrame:self.tempView.frame cardText:@"" password:@"" cardPlaceholder:@"请输入账号" passwordPlaceholder:@"请输入密码"];
    
    [self.tempView addSubview:self.loginV];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
    [super setSelected:selected animated:animated];


}

- (void)layoutSubviews{
    
    self.loginV.frame = CGRectMake(0, 0, self.tempView.frame.size.width, self.tempView.frame.size.height);
    
}

- (void)clickLogin:(clickLoginButtonBlock)login clickRegist:(clickRegistButtonBlock)regist{
    
    self.loginBlock = login;
    
    self.registBlock = regist;
    
}
- (IBAction)loginAction:(id)sender {
    
    if (self.loginBlock) {
        self.loginBlock(self.loginV.cardTextField.text, self.loginV.passwordTextField.text);
    }

}

- (IBAction)registAction:(id)sender {
    
    if (self.registBlock) {
        self.registBlock();
    }
    
    
}

@end
