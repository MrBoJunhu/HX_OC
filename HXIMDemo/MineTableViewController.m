//
//  MineTableViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "MineTableViewController.h"
#import "LoginTableViewController.h"
#import "NewMsgTableViewController.h"

@interface MineTableViewController ()

@end

@implementation MineTableViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.title = @"我的";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:self action:@selector(existHXAction:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUI) name:HXConnectStateChanged object:nil];
    
}

- (void)reloadUI {
    
    @weakself(self);
    
   dispatch_async(dispatch_get_main_queue(), ^{
     
       [weakself.tableView reloadData];
       
   });

}


- (void)viewWillAppear:(BOOL)animated {
   
    [super viewWillAppear:animated];
    
    [self showTabbar];
    
    [self.tableView reloadData];
    
}

- (void)existHXAction:(UIBarButtonItem *)sender {
    
    [[HXManagerHelper shareHXManagerHelper] existHXServiceSuccess:^{
       
        LoginTableViewController *loginVC = [[LoginTableViewController alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        
    } faile:^{
        
        
    }];
    
}


                                  
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    static NSString *cellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        

    NSString *title = @"";
    
    NSString *subTitle = @"";
    
    NSUInteger row = indexPath.row;
    
    if (row == 0) {
        
        title = @"用户名";
        
        subTitle = [HXManagerHelper shareHXManagerHelper].emClient.currentUsername;
        
    }else if (row == 1){
        
        title = @"登录状态";
      
        if ([[HXManagerHelper shareHXManagerHelper].emClient isLoggedIn]) {
        
            subTitle = @"已登录";
        
        }else{
        
            subTitle = @"未登录";
        
        }
        
    }else if (row == 2){
      
        title = @"连接服务器状态";
       
        if ([HXManagerHelper shareHXManagerHelper].isConnectingHXService) {
            
            subTitle = @"已连接";
        
        }else{
           
            subTitle = @"已断开";
            
        }

    }else if (row == 3){
        
        title = @"是否开启自动登录";
       
        if ([HXManagerHelper shareHXManagerHelper].emClient.isAutoLogin) {
            
            subTitle = @"已开启";
            
        }else{
            
            subTitle = @"已关闭";
            
        }
    }else if (row == 4){
        title = @"好友申请";
        subTitle = @"查看更多";
    }
    
    cell.textLabel.text = title;
    
    cell.detailTextLabel.backgroundColor = [UIColor redColor];
    
    cell.detailTextLabel.text = subTitle;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger row = indexPath.row;
    
    if (row == 4) {
        
        NewMsgTableViewController *msgVC = [[NewMsgTableViewController alloc] init];

        [self.navigationController pushViewController:msgVC animated:YES];

    }
    
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HXConnectStateChanged object:nil];
    
}

@end
