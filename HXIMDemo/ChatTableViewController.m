//
//  ChatTableViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//  会话列表

#import "ChatTableViewController.h"

#import "EaseEmotionEscape.h"
#import "EaseConversationCell.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "EaseMessageViewController.h"
#import "NSDate+Category.h"
#import "EaseLocalDefine.h"

#import "ChatDetailViewController.h"

@interface ChatTableViewController ()


@property (nonatomic, strong) NSMutableArray *msgArray;

@end

@implementation ChatTableViewController

- (NSMutableArray *)msgArray{
    
    if (!_msgArray) {
        self.msgArray = [NSMutableArray array];
    }
    return _msgArray;
}

- (void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:animated];
    
    [self showTabbar];
    
    //首次进入加载数据
    [self tableViewDidTriggerHeaderRefresh];
    
}

- (void)viewWillDisappear:(BOOL)animated {
   
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"会话";
    
    self.showRefreshHeader = YES;
    
    self.delegate = self;
    
    self.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reladNewMessage) name:HXDidRecivedNewMessage object:nil];
    
}

- (void)reladNewMessage {
   
    [self.tableView reloadData];
    
}



- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel{
    
    ChatDetailViewController *detailVC = [[ChatDetailViewController alloc] initWithConversationChatter:conversationModel.conversation.conversationId conversationType:EMConversationTypeChat];
  
    detailVC.title = conversationModel.title;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HXDidRecivedNewMessage object:nil];
}

@end
