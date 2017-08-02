//
//  LoginTableViewCell.h
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickLoginButtonBlock)(NSString *card, NSString *password);

typedef void(^clickRegistButtonBlock)();

@interface LoginTableViewCell : UITableViewCell

- (void)clickLogin:(clickLoginButtonBlock)login clickRegist:(clickRegistButtonBlock)regist;



@end
