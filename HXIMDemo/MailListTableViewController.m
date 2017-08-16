//
//  MailListTableViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "MailListTableViewController.h"

#import "AddNewFriendViewController.h"

#import "ChatDetailViewController.h"

@interface MailListTableViewController ()<EMUserListViewControllerDelegate>

@end

@implementation MailListTableViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewFriends)];
    
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self showTabbar];
    
}

- (void)addNewFriends {
    
    AddNewFriendViewController *addVC = [[AddNewFriendViewController alloc] init];
   
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:addVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


- (void)userListViewController:(EaseUsersListViewController *)userListViewController didDeleteUserModel:(id<IUserModel>)userModel {
    
    
}

- (void)userListViewController:(EaseUsersListViewController *)userListViewController didSelectUserModel:(id<IUserModel>)userModel {
    
    DebugLog(@"%@", userModel);
    
    ChatDetailViewController *detailVC = [[ChatDetailViewController alloc]  initWithConversationChatter:userModel.buddy conversationType:EMConversationTypeChat];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


@end
