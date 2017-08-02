//
//  LoginTableViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "LoginTableViewController.h"
#import "LoginTableViewCell.h"
#import "RegistTableViewController.h"
#import "HomeTabBarController.h"

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *loginCellIdentifier = @"LoginTableViewCell";
    
    LoginTableViewCell *loginCell = [tableView dequeueReusableCellWithIdentifier:loginCellIdentifier];
    
    if (!loginCell) {
        loginCell = [[NSBundle mainBundle] loadNibNamed:loginCellIdentifier owner:self options:nil].firstObject;
        
        [tableView registerNib:[UINib nibWithNibName:loginCellIdentifier bundle:nil] forCellReuseIdentifier:loginCellIdentifier];
    }
    
    @weakself(self);
    
    [loginCell clickLogin:^(NSString *card, NSString *password) {
        
        DebugLog(@"card: %@,password :  %@", card, password);
       
        [[HXManagerHelper shareHXManagerHelper] loginHXServiceWithUsername:card password:password loginSuccess:^(NSString *responseData) {
        
            HomeTabBarController *homeTab = [[HomeTabBarController alloc] init];
            
            [weakself.navigationController pushViewController:homeTab animated:YES];
            
        } loginFaile:^(NSString *errorDescription, EMErrorCode errorCode) {
            
            
            
        }];
    
    } clickRegist:^{
        
        RegistTableViewController *registVC= [[RegistTableViewController alloc] init];
        
        [weakself.navigationController pushViewController:registVC animated:YES];
        
    }];
    
    return loginCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat screen_Height = [UIScreen mainScreen].bounds.size.height;

    return screen_Height - 200;
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
