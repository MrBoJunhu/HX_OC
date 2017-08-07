//
//  AlertManager.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/7.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "AlertManager.h"

@interface AlertManager()

@property (nonatomic, copy) clickOKBlock okBlock;

@property (nonatomic, copy) clickCancelBlock cancelBlock;

@end

@implementation AlertManager

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

+ (void)showAlertMessagerWithController:(UIViewController *)controller Title:(NSString *)msgTitle content:(NSString *)content okTitle:(NSString *)okTitle cancelTitle:(NSString *)cancelTitle alertType:(AlertActionType)alertType clickOk:(clickOKBlock)ok cancel:(clickCancelBlock)cancel{
    
    AlertManager *manager = [[self alloc] init];
    
    manager.okBlock = ok;
    
    manager.cancelBlock = cancel;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:msgTitle message:content preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        if (manager.okBlock) {
            manager.okBlock();
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        if (manager.cancelBlock) {
            manager.cancelBlock();
        }
        
    }];
    
    if (alertType == One_AlertActionType) {
      
        [alertController addAction:action];
        
    }else if (alertType == Two_AlertActionType){
        
        [alertController addAction:action];
        
        [alertController addAction:cancelAction];
    
    }
    
    [controller presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

@end
