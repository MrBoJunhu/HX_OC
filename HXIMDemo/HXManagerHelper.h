//
//  HXManagerHelper.h
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HXServiceType) {
    HXServiceType_Dev = 0,
    HXServiceType_Dis
};

typedef void(^registSuccess)(NSString * responseData);
typedef void(^registFaile)(NSString *errorDescription, EMErrorCode errorCode);

typedef void(^loginSuccess)(NSString * responseData);
typedef void(^loginFaile)(NSString *errorDescription, EMErrorCode errorCode);


typedef void(^logoutSuccess)();
typedef void(^logoutFaile)(NSString *erroeDescription);

@interface HXManagerHelper : NSObject

@property (nonatomic, strong) EMClient *emClient;

@property (nonatomic, strong) EaseSDKHelper *SDKHelper;

@property (nonatomic, copy) NSString *managerHXAppKey;

@property (nonatomic, copy) NSString *managerHXCerName;

+(instancetype)shareHXManagerHelper;


/**
 环信配置
 */
- (void)cofigurateLocalHXService;

/**
 环信注册

 @param username username description
 @param password password description
 @param success success description
 @param faile faile description
 */
- (void)registHXServiceWithUsername:(NSString *)username password:(NSString *)password registSuccess:(registSuccess)success registFaile:(registFaile)faile;

/**
 环信登陆

 @param username username description
 @param password password description
 @param success success description
 @param faile faile description
 */
- (void)loginHXServiceWithUsername:(NSString *)username password:(NSString *)password loginSuccess:(loginSuccess)success loginFaile:(loginFaile)faile;


- (void)existHXServiceSuccess:(logoutSuccess)success faile:(logoutSuccess)faile;

@end
