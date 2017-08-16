//
//  HXManagerHelper.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "HXManagerHelper.h"

#import "LoginTableViewController.h"

@interface HXManagerHelper()<EMClientDelegate,EMChatManagerDelegate, EMContactManagerDelegate>

@property (nonatomic, copy) registSuccess registSuccessBlock;
@property (nonatomic, copy) registFaile registFaileBlock;

@property (nonatomic, copy) loginSuccess loginSuccessBlock;
@property (nonatomic, copy) loginFaile loginFaileBlock;


@property (nonatomic, copy) logoutSuccess logoutSuccessBlock;
@property (nonatomic, copy) logoutFaile logoutFaileBlock;


@property (nonatomic, copy) sendAddNewsSuccess sendAddSuccessBlock;
@property (nonatomic, copy) sendAddNewsFaile sendAddFaileBlock;


@property (nonatomic, copy) completeSuccess successBlock;
@property (nonatomic, copy) completeFaile faileBlock;


//好友列表
@property (nonatomic, copy) contactsListBlock contactsListBlock;


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

- (void)clearMsg{
    
    self.addAUsername = nil;
    self.addAMessage = nil;
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

#pragma mark - 环信配置
- (void)cofigurateLocalHXService:(UIApplication *)application {

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
    
    // 配置APNs使用的推送证书
    options.apnsCertName = self.managerHXCerName;
    
    [self.emClient initializeSDKWithOptions:options];

    
        
    //设置推送昵称
    [self.emClient setApnsNickname:@"环信测试应用"];
    
    EMPushOptions *pushOptions = self.emClient.pushOptions;
    
    // 设置推送显示的样式 : 显示消息详情
    pushOptions.displayStyle = EMPushDisplayStyleSimpleBanner;
    
    //更新推送配置到服务器
    [self.emClient updatePushNotificationOptionsToServerWithCompletion:^(EMError *aError) {
        
        if (!aError) {
            
            DebugLog(@"更新推送到服务器成功!");
            
        }else{
            
            DebugLog(@"更新配置到服务器失败");
            
        }
        
    }];
    
    //添加回调监听代理
    [self.emClient addDelegate:self delegateQueue:nil];
    
    //注册消息回调 EMChatManagerDelegate
    [self.emClient.chatManager removeDelegate:self];
    [self.emClient.chatManager addDelegate:self delegateQueue:nil];
    
    //添加好友回调监听
    [self.emClient.contactManager addDelegate:self delegateQueue:nil];
    
}

#pragma mark - 注册环信


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

#pragma mark - 退出登录
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

#pragma mark - 发送添加好友请求
- (void)addNewFriendWithUsername:(NSString *)username success:(sendAddNewsSuccess)success faile:(sendAddNewsFaile)faile {
    
    self.sendAddSuccessBlock = success;
    
    self.sendAddFaileBlock = faile;
    
    @weakself(self);
    
    [self.emClient.contactManager addContact:username message:[NSString stringWithFormat:@" %@ ,你好, 我是%@, 我可以添加你为好友么", username, self.emClient.currentUsername] completion:^(NSString *aUsername, EMError *aError) {
       
        if (!aError) {
            DebugLog(@"发送添加好友请求成功!");
            weakself.sendAddSuccessBlock();
        }else{
            DebugLog(@"发送添加好友请求失败!\n aError.errorDescription : %@ ", aError.errorDescription);
            weakself.sendAddFaileBlock(aError.errorDescription, aError.code);
        }
        
    }];
}

#pragma mark - 同意新的添加好友申请
- (void)agreeAddNewFriendWithUsername:(NSString *)username success:(completeSuccess)success faile:(completeFaile)faile{
    
    self.successBlock = success;
    
    self.faileBlock = faile;
    
    @weakself(self);
    
    [self.emClient.contactManager approveFriendRequestFromUser:username completion:^(NSString *aUsername, EMError *aError) {
       
        if (!aError) {
            DebugLog(@"同意添加好友成功");
            weakself.successBlock();
            
        }else{
            DebugLog(@"同意添加好友失败");

            weakself.faileBlock(aError.errorDescription, aError.code);
        }
        
    }];
}
#pragma mark - 拒绝添加好友
- (void)disagreeAddNewFriendWithUsername:(NSString *)username success:(completeSuccess)success faile:(completeFaile)faile {
    
    self.successBlock = success;
    
    self.faileBlock = faile;
    
    
    @weakself(self);
    
    [self.emClient.contactManager declineFriendRequestFromUser:username completion:^(NSString *aUsername, EMError *aError) {
    
        if (!aError) {
            DebugLog(@"拒绝添加好友成功");

            weakself.successBlock();
        }else{
            DebugLog(@"拒绝添加好友失败");
            weakself.faileBlock(aError.errorDescription, aError.code);
        }
        
    }];
    
}
#pragma mark - 删除好友
- (void)deleteFriendWithUsername:(NSString *)username success:(completeSuccess)success faile:(completeFaile)faile{
    
    self.successBlock = success;
    
    self.faileBlock = faile;
    
    @weakself(self);
    
    [self.emClient.contactManager deleteContact:username isDeleteConversation:YES completion:^(NSString *aUsername, EMError *aError) {
        
        if (!aError) {
            DebugLog(@"删除好友成功");
            weakself.successBlock();
        }else{
            DebugLog(@"删除好友失败");

            weakself.faileBlock(aError.errorDescription, aError.code);
        }
        
    }];
}

#pragma mark - 从服务器获取好友列表
- (void)getContactsListFromService:(contactsListBlock)contactsList faile:(completeFaile)faile{
    
    self.contactsListBlock = contactsList;
    self.faileBlock = faile;
    
    @weakself(self);
    
    [self.emClient.contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
       
        if (!aError) {
            DebugLog(@"获取好友列表成功!");
            DebugLog(@"好友列表:\n %@", aList);
            weakself.contactsListBlock(aList);
        }else{
            DebugLog(@"获取好友列表失败");
            weakself.faileBlock(aError.errorDescription, aError.code);
        }
        
    }];
    
    //获取本地存储的所有好友
//    [self.emClient.contactManager getContacts];
    
}

#pragma mark - 删除会话

- (void)deleteChatWithConversationId:(NSString *)ConversationId success:(completeSuccess)success  faile:(completeFaile)faile {
    
    self.successBlock = success;
    
    self.faileBlock = faile;
    
    @weakself(self);
    
    [self.emClient.chatManager deleteConversation:ConversationId isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError) {
        
        if (!aError) {
        
            weakself.successBlock();
      
        }else{
            
            weakself.faileBlock(aError.errorDescription, aError.code);
            
        }
        
    }];
    
}



#pragma mark - EMClientDelegate 

/*!

 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况, 会引起该方法的调用:
 *  1. 登录成功后, 手机无法上网时, 会调用该回调
 *  2. 登录成功后, 网络状态变化时, 会调用该回调
 *
 *  @param aConnectionState 当前状态
 *
 *  \~english
 *  Invoked when server connection state has changed
 *
 *  @param aConnectionState Current state
 */
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    
    if (aConnectionState == EMConnectionConnected) {
    
        DebugLog(@"已连接");
        self.isConnectingHXService = YES;

    }else if (aConnectionState == EMConnectionDisconnected){
    
        DebugLog(@"未连接");
        self.isConnectingHXService = NO;
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HXConnectStateChanged object:nil];
    
}


/*!
 *  \~chinese
 *  自动登录完成时的回调
 *
 *  @param aError 错误信息
 *
 *  \~english
 *  Invoked when auto login is completed
 *
 */
- (void)autoLoginDidCompleteWithError:(EMError *)aError{
    
    if (aError == nil) {
    
        DebugLog(@"自动登录成功!");
    
    }else{
    
        DebugLog(@"自动登录失败!");
    
    }

}

#pragma mark - 当前登录账号在其它设备登录时会接收到该回调

- (void)userAccountDidLoginFromOtherDevice{
    
    DebugLog(@"当前登录账号在其它设备登录,请重新登录!");
    @weakself(self);
    
    [AlertManager showAlertMessagerWithController:[UIApplication sharedApplication].keyWindow.rootViewController Title:TipTitle content:@"当前登录账号在其它设备登录,请重新登录!" okTitle:LoginAgainTip cancelTitle:CancelTip alertType:One_AlertActionType clickOk:^{
        
        [weakself existHXServiceSuccess:^{
            
            [weakself jumpToLoginController];

        } faile:^{
            
        }];
        
    } cancel:^{
        
    }];
}

#pragma mark - 当前登录账号已经被从服务器端删除时会收到该回调

- (void)userAccountDidRemoveFromServer{
    
    DebugLog(@"当前登录账号已经被从服务器端删除时会收到该回调");
    
    @weakself(self);
   
    [AlertManager showAlertMessagerWithController:[UIApplication sharedApplication].keyWindow.rootViewController Title:TipTitle content:@"当前登录账号已经被从服务器端删除时会收到该回调" okTitle:LoginAgainTip cancelTitle:CancelTip alertType:One_AlertActionType clickOk:^{
       
        [weakself existHXServiceSuccess:^{
            
            [weakself jumpToLoginController];
            
        } faile:^{
            
        }];
        
    } cancel:^{
        
    }];
    
}

#pragma mark - 好友管理

#pragma mark - EMContactManagerDelegate

/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage{
    
    DebugLog(@"收到添加好友的申请消息 %@", aMessage);
    
    self.addAUsername  = aUsername;
    
    self.addAMessage = aMessage;
}


/*!
 @method
 @brief 获取好友列表成功时的回调
 @param buddyList 好友列表
 @param error     错误信息
 */
- (void)didFetchedBuddyList:(NSArray *)buddyList
                      error:(EMError *)error{
    
    DebugLog(@"获取到好友列表:\n %@", buddyList);
    
    
}

/*!
 @method
 @brief 接收到好友请求时的通知

 @param username 发起好友请求的用户username
 @param message  收到好友请求时的say hello消息
 */
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message{

    
    
}


#pragma mark - EMChatManagerDelegate

//在线普通消息会走以下回调
/*!
 @method
 @brief 接收到一条及以上非cmd消息
 */
- (void)messagesDidReceive:(NSArray *)aMessage {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HXDidRecivedNewMessage object:nil];
    
}


- (void)cmdMessagesDidReceive:(NSArray *)aCmdMessages {
    
    
}


/*!
 @method
 @brief 将要接收离线消息的回调
 */
- (void)willReceiveOfflineMessages {
    
}

/*!
 @method
 @brief 离线非透传消息接收完成的回调
 @discussion
 @param offlineMessages 接收到的离线列表
 @result
 */
- (void)didFinishedReceiveOfflineMessages {
    
    
    
}


#pragma mark - 返回登录页面

- (void)jumpToLoginController {
    
    LoginTableViewController *loginVC = [[LoginTableViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;

}


@end
