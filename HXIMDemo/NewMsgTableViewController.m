//
//  NewMsgTableViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/8.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "NewMsgTableViewController.h"

#import "MsgTableViewCell.h"

#import "TestViewController.h"

@interface NewMsgTableViewController ()

@end

@implementation NewMsgTableViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];
 
    self.title = @"消息列表";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
 
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(testAction)];
    
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)testAction {
 
    TestViewController *testVC = [[TestViewController alloc] init];
    
    [self.navigationController pushViewController:testVC animated:YES];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *addName = [HXManagerHelper shareHXManagerHelper].addAUsername;
    
    if (addName.length > 0 ) {
        return 1;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_Identifier = @"MsgTableViewCell";
    
    MsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Identifier];
    
    if (!cell) {
       
        cell = [[NSBundle mainBundle] loadNibNamed:cell_Identifier owner:self options:nil].firstObject;
        
        [tableView registerNib:[UINib nibWithNibName:cell_Identifier bundle:nil] forCellReuseIdentifier:cell_Identifier];
        
    }
    
    NSString *name = [HXManagerHelper shareHXManagerHelper].addAUsername;
    
    NSString *msg = [HXManagerHelper shareHXManagerHelper].addAMessage;
    
    [cell reloadMsgTableViewCellUIWithTitle:[NSString stringWithFormat:@"申请人 : %@", name] msg:msg clickAgree:^{
        
        //同意加好友
        
        [[HXManagerHelper shareHXManagerHelper] agreeAddNewFriendWithUsername:name success:^{
           
            [[HXManagerHelper shareHXManagerHelper] clearMsg];
           
            [tableView reloadData];
            
        } faile:^(NSString *arrorDescription, EMErrorCode errorCode) {
            
        }];
        
    } disagree:^{
        
        //拒绝加好友
        
        [[HXManagerHelper shareHXManagerHelper] disagreeAddNewFriendWithUsername:name success:^{
            
            [[HXManagerHelper shareHXManagerHelper] clearMsg];
            
            [tableView reloadData];
            
        } faile:^(NSString *arrorDescription, EMErrorCode errorCode) {
            
        }];
        
    }];

    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}


@end
