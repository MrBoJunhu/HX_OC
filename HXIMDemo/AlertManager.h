//
//  AlertManager.h
//  HXIMDemo
//
//  Created by BillBo on 2017/8/7.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^clickOKBlock)();

typedef void(^clickCancelBlock)();

typedef NS_ENUM(NSUInteger, AlertActionType) {
    One_AlertActionType,
    Two_AlertActionType
};

@interface AlertManager : NSObject

+ (void)showAlertMessagerWithController:(UIViewController *)controller Title:(NSString *)msgTitle content:(NSString *)content okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle alertType:(AlertActionType)alertType clickOk:(clickOKBlock)ok  cancel:(clickCancelBlock)cancel;


@end
