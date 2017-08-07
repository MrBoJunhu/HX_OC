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

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //环信SDK 初始化
    [[HXManagerHelper shareHXManagerHelper] cofigurateLocalHXService];
    
    [[HXManagerHelper shareHXManagerHelper].SDKHelper hyphenateApplication:application didFinishLaunchingWithOptions:launchOptions appkey:[HXManagerHelper shareHXManagerHelper].managerHXAppKey apnsCertName:[HXManagerHelper shareHXManagerHelper].managerHXCerName otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
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
