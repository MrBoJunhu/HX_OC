//
//  HXManagerHelper.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "HXManagerHelper.h"

@interface HXManagerHelper()

@property (nonatomic, copy) registSuccess registSuccessBlock;
@property (nonatomic, copy) registFaile registFaileBlock;

@property (nonatomic, copy) loginSuccess loginSuccessBlock;
@property (nonatomic, copy) loginFaile loginFaileBlock;

@property (nonatomic, assign) HXServiceType hxServiceType;

@end

@implementation HXManagerHelper

+(instancetype)shareHXManagerHelper{
    
    static HXManagerHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc] init];
        helper.hxServiceType = HXServiceType_Dev;
    });
    
    return helper;
    
}

- (EMClient *)emClient{
    
    if (!_emClient) {
        self.emClient = [EMClient sharedClient];
    }
    
    return _emClient;
}

- (void)cofigurateLocalHXService {
    
    NSString *hxAppKey = @"";
    NSString *hxAPSCertName = @"";
    
    if (self.hxServiceType == HXServiceType_Dev) {
        //开发环境
        hxAppKey = HXApp_Key_dev;
        hxAPSCertName = HXCer_Name_dev;
        
    }else if (self.hxServiceType == HXServiceType_Dis){
        //生产环境
        hxAppKey = HXApp_Key_dis;
        hxAPSCertName = HXCer_Name_dis;
    }
   
    EMOptions *options = [EMOptions optionsWithAppkey:HXApp_Key_dev];
    
    [self.emClient initializeSDKWithOptions:options];
    
}


- (void)registHXServiceWithUsername:(NSString *)username password:(NSString *)password registSuccess:(registSuccess)success registFaile:(registFaile)faile{
    
    self.registSuccessBlock  = success;
    
    self.registFaileBlock  = faile;
    
    @weakself(self);
    
    [self.emClient registerWithUsername:username password:password completion:^(NSString *aUsername, EMError *aError) {
       
        if (!aError) {
        
            DebugLog(@"注册成功!");
            weakself.loginSuccessBlock(aUsername);
            
        }else{
           
            DebugLog(@"注册失败!");
            DebugLog(@"%@ \n %d", aError.errorDescription, aError.code)
            weakself.registFaileBlock(aError.errorDescription, aError.code);
        
        }
   
    }];
    
}

- (void)loginHXServiceWithUsername:(NSString *)username password:(NSString *)password loginSuccess:(loginSuccess)success loginFaile:(loginFaile)faile{
    
    self.loginSuccessBlock = success;
    
    self.loginFaileBlock = faile;
   
    @weakself(self);
    
    [self.emClient loginWithUsername:username password:password completion:^(NSString *aUsername, EMError *aError) {
    
        if (!aError) {
           
            DebugLog(@"登陆成功!");
            weakself.loginSuccessBlock(username);
            
        }else{
            DebugLog(@"登陆失败!");
            DebugLog(@"%@ \n %d", aError.errorDescription, aError.code)
            weakself.loginFaileBlock(aError.errorDescription, aError.code);
        
            
        }
        
    }];
    
}

@end
