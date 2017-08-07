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
//注册环信
typedef void(^registSuccess)(NSString * responseData);
typedef void(^registFaile)(NSString *errorDescription, EMErrorCode errorCode);

//登录
typedef void(^loginSuccess)(NSString * responseData);
typedef void(^loginFaile)(NSString *errorDescription, EMErrorCode errorCode);

//退出登录
typedef void(^logoutSuccess)();
typedef void(^logoutFaile)(NSString *erroeDescription);

//发送添加好友请求
typedef void(^sendAddNewsSuccess)();
typedef void(^sendAddNewsFaile)(NSString *arrorDescription, EMErrorCode errorCode);

//通用操作类成功失败处理
typedef void(^completeSuccess)();
typedef void(^completeFaile)(NSString *arrorDescription, EMErrorCode errorCode);



//获取所有好友
typedef void(^contactsListBlock)(NSArray *userList);


@interface HXManagerHelper : NSObject

@property (nonatomic, strong) EMClient *emClient;

@property (nonatomic, strong) EaseSDKHelper *SDKHelper;



@property (nonatomic, copy) NSString *managerHXAppKey;

@property (nonatomic, copy) NSString *managerHXCerName;

/**
 环信服务器的连接状态
 */
@property (nonatomic, assign) BOOL isConnectingHXService;

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


/**
 退出环信登录

 @param success success description
 @param faile faile description
 */
- (void)existHXServiceSuccess:(logoutSuccess)success faile:(logoutSuccess)faile;


/**
 发送添加好友申请

 @param username username description
 @param success success description
 @param faile faile description
 */
- (void)addNewFriendWithUsername:(NSString *)username success:(sendAddNewsSuccess)success faile:(sendAddNewsFaile)faile;


/**
 同意添加好友申请成功

 @param username username description
 @param success success description
 @param faile faile description
 */
- (void)agreeAddNewFriendWithUsername:(NSString *)username success:(completeSuccess)success faile:(completeFaile)faile;

/**
 拒绝好友申请

 @param username username description
 @param success success description
 @param faile faile description
 */
- (void)disagreeAddNewFriendWithUsername:(NSString *)username success:(completeSuccess)success faile:(completeFaile)faile;

/**
 删除好友

 @param username username description
 @param success success description
 @param faile faile description
 */
- (void)deleteFriendWithUsername:(NSString *)username success:(completeSuccess)success faile:(completeFaile)faile;

/**
 从服务器获取所有的好友

 @param contactsList contactsList description
 */
- (void)getContactsListFromService:(contactsListBlock)contactsList faile:(completeFaile)faile;




/**
 删除单个会话
 
 @param ConversationId 会话id
 @param success success description
 @param faile faile description
 */
- (void)deleteChatWithConversationId:(NSString *)ConversationId success:(completeSuccess)success  faile:(completeFaile)faile;

@end
