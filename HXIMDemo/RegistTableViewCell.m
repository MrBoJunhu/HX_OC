//
//  RegistTableViewCell.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "RegistTableViewCell.h"
#import "LoginView.h"
@interface RegistTableViewCell()

@property (strong, nonatomic) IBOutlet UIView *registTempView;

@property (nonatomic, strong) LoginView * registV;

@property (nonatomic, copy) clickRegistBlock registBlock;


@end

@implementation RegistTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];

    self.registV = [LoginView initWithLoginViewFrame:CGRectZero cardText:@"" password:@"" cardPlaceholder:@"请输入账号" passwordPlaceholder:@"请输入密码"];
    
    [self.registTempView addSubview:self.registV];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
    [super setSelected:selected animated:animated];

}

- (void)layoutSubviews{
    
    self.registV.frame = RECT(0, 0, self.registTempView.frame.size.width, self.registTempView.frame.size.height);
}

- (IBAction)registAction:(id)sender {

    if (self.registBlock) {
        self.registBlock(self.registV.cardTextField.text, self.registV.passwordTextField.text);
    }
}

- (void)clickRegist:(clickRegistBlock)regist{
    
    self.registBlock = regist;
    
}

@end
