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


@property (nonatomic, copy) logoutSuccess logoutSuccessBlock;
@property (nonatomic, copy) logoutFaile logoutFaileBlock;



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

- (EaseSDKHelper *)SDKHelper{
    
    if (!_SDKHelper) {
        self.SDKHelper = [EaseSDKHelper shareHelper];
    }
    
    return _SDKHelper;
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
   
    self.managerHXAppKey = hxAppKey;
    
    self.managerHXCerName = hxAPSCertName;
    
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
            weakself.registSuccessBlock(aUsername);
            
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
            //SDK 中自动登录属性默认是关闭的，需要您在登录成功后设置，以便您在下次 APP 启动时不需要再次调用环信登录，并且能在没有网的情况下得到会话列表。
            [weakself.emClient.options  setIsAutoLogin:YES];
           
            //控制台是否输出log, 默认为NO
            [weakself.emClient.options enableConsoleLog];

            weakself.loginSuccessBlock(username);
            
        }else{
            DebugLog(@"登陆失败!");
            DebugLog(@"%@ \n %d", aError.errorDescription, aError.code)
            weakself.loginFaileBlock(aError.errorDescription, aError.code);
            
        }
        
    }];
    
}

- (void)existHXServiceSuccess:(logoutSuccess)success faile:(logoutSuccess)faile{
    
    self.logoutSuccessBlock = success;
    
    self.logoutFaileBlock = faile;
    
    @weakself(self);
    
    [self.emClient logout:YES completion:^(EMError *aError) {
        
        if (!aError) {
            
            DebugLog(@"退出登录成功!");
            
            weakself.logoutSuccessBlock();
        
        }else{
            
            DebugLog(@"退出登录失败 : %@", aError.errorDescription);
            
            weakself.logoutFaileBlock(aError.errorDescription);
            
        }
        
    }];

    
}
@end
