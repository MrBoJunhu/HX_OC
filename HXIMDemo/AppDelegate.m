//
//  AppDelegate.m
//  HXIMDemo
//
//  Created by BillBo on 2017/7/28.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginTableViewController.h"

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //环信SDK 初始化
    [[HXManagerHelper shareHXManagerHelper] cofigurateLocalHXService];
    
    [[UINavigationBar appearance] setBarTintColor:RGBColor(250, 102, 102)];

    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    LoginTableViewController *loginVC = [[LoginTableViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    self.window.rootViewController = nav;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
