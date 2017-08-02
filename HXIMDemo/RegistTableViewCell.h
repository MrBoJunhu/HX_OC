//
//  RegistTableViewCell.h
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickRegistBlock)(NSString *card, NSString *password);

@interface RegistTableViewCell : UITableViewCell

- (void)clickRegist:(clickRegistBlock)regist;


@end
