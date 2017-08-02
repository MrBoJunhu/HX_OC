//
//  HomeTabBarController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "HomeTabBarController.h"
#import "ChatTableViewController.h"
#import "MailListTableViewController.h"
#import "MineTableViewController.h"
@interface HomeTabBarController ()

@end

@implementation HomeTabBarController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    ChatTableViewController *chatVC = [[ChatTableViewController alloc] init];
   
    chatVC.tabBarItem.selectedImage = [UIImage imageNamed:@"chat_selected"];
    
    chatVC.tabBarItem.image = [UIImage imageNamed:@"chat"];
    
    chatVC.title = @"会话";
    
    MailListTableViewController *mailVC = [[MailListTableViewController alloc] init];
    
    mailVC.tabBarItem.selectedImage = [UIImage imageNamed:@"mail_selected"];
    
    mailVC.tabBarItem.image = [UIImage imageNamed:@"mail"];
    
    mailVC.title = @"通讯录";
    
    MineTableViewController *mineVC = [[MineTableViewController alloc] init];
    
    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_selected"];
    
    mineVC.tabBarItem.image = [UIImage imageNamed:@"mine"];
    
    mineVC.tabBarItem.title = @"我的";
    
    UINavigationController *chatNAV = [[UINavigationController alloc] initWithRootViewController:chatVC];
    
    UINavigationController *mailNAV = [[UINavigationController alloc] initWithRootViewController:mailVC];
    
    UINavigationController *mineNAV = [[UINavigationController alloc] initWithRootViewController:mineVC
                                       ];
    
    [self addChildViewController:chatNAV];
    
    [self addChildViewController:mailNAV];
    
    [self addChildViewController:mineNAV];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)didReceiveMemoryWarning {
   
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
