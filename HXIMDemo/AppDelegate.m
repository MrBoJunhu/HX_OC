//

//  AppDelegate.m
//  HXIMDemo
//
//  Created by BillBo on 2017/7/28.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginTableViewController.h"

#import "HomeTabBarController.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //环信SDK 初始化
    [[HXManagerHelper shareHXManagerHelper] cofigurateLocalHXService:application];
    
    
    //环信注册远程通知
    [[HXManagerHelper shareHXManagerHelper].SDKHelper hyphenateApplication:application didFinishLaunchingWithOptions:launchOptions appkey:[HXManagerHelper shareHXManagerHelper].managerHXAppKey apnsCertName:[HXManagerHelper shareHXManagerHelper].managerHXCerName otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    //注册环信推送功能
    [self registHXPushFunction:application];
    
    
    //导航栏背景色
    [[UINavigationBar appearance] setBarTintColor:Home_Color];
    
    //导航栏标题
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           
                                                           NSForegroundColorAttributeName :[UIColor whiteColor],
                                                           NSFontAttributeName :[UIFont systemFontOfSize:18]
                                                           }];
    
    //设置tabbar背景色
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    //小角标颜色
    [[UITabBarItem appearance] setBadgeColor:[UIColor redColor]];
    
    //tabbarItem选中颜色
    [[UITabBar appearance] setTintColor:Home_Color];

    // navigationItem 颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    BOOL hasLogin = [[HXManagerHelper shareHXManagerHelper].emClient isAutoLogin];
    
    if (hasLogin) {
        
        HomeTabBarController *homeTab = [[HomeTabBarController alloc] init];
        
        self.window.rootViewController = homeTab;
        
    }else{
        
        LoginTableViewController *loginVC = [[LoginTableViewController alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        self.window.rootViewController = nav;
        
    }

    
    return YES;
}


#pragma mark - 注册推送

- (void)registHXPushFunction:(UIApplication *)application {
    
    //iOS10 注册 APNS
    
    //iOS10 注册APNs
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError *error) {
            if (granted) {
#if !TARGET_IPHONE_SIMULATOR
                [application registerForRemoteNotifications];
#endif
            }
        }];
        return;
    }
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
    
}

#pragma mark - 您注册了推送功能，iOS 会自动回调以下方法，得到 deviceToken，您需要将 deviceToken 传给 SDK。

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  
    // 将得到的deviceToken传给SDK
    [[HXManagerHelper shareHXManagerHelper].emClient bindDeviceToken:deviceToken];
    
    DebugLog(@"注册环信推送成功!");
    
}

#pragma mark - 收到推送消息

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    DebugLog(@"收到推送消息");
    
    

}

#pragma mark - 注册deviceToken失败

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    DebugLog(@"注册deviceToken失败 : %@", error);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {

    
    
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {

    [[HXManagerHelper shareHXManagerHelper].emClient applicationDidEnterBackground:application];
    
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {

    [[HXManagerHelper shareHXManagerHelper].emClient applicationWillEnterForeground:application];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    
}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
