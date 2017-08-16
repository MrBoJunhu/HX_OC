//
//  MsgTableViewCell.h
//  HXIMDemo
//
//  Created by BillBo on 2017/8/8.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickAgrBlock)();

typedef void(^clickDisAgrBlock)();

@interface MsgTableViewCell : UITableViewCell

- (void)reloadMsgTableViewCellUIWithTitle:(NSString *)title msg:(NSString *)msg clickAgree:(clickAgrBlock)agree disagree:(clickDisAgrBlock)disagree;


@end
