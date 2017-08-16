//
//  ChatDetailViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/8.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "ChatDetailViewController.h"

@interface ChatDetailViewController ()


@end

@implementation ChatDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
       
    [self hiddenTabbar];
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.showRefreshHeader = YES;

    self.dataSource = self;
    
    self.delegate = self;
    
    self.title = [NSString stringWithFormat:@"和%@聊天", self.conversation.conversationId];
    
}


- (void)messageViewController:(EaseMessageViewController *)viewController didSelectAvatarMessageModel:(id<IMessageModel>)messageModel {
    
    DebugLog(@"点击用户头像");
    
}

- (void)messageViewController:(EaseMessageViewController *)viewController
 didReceiveHasReadAckForModel:(id<IMessageModel>)messageModel{
    
}

@end
