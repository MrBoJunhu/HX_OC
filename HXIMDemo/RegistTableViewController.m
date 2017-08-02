//
//  RegistTableViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "RegistTableViewController.h"
#import "RegistTableViewCell.h"
@interface RegistTableViewController ()

@end

@implementation RegistTableViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];

    self.navigationItem.title = @"注册";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
     self.clearsSelectionOnViewWillAppear = NO;
    
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

    static NSString *registCellIdentifier = @"RegistTableViewCell";
    
    RegistTableViewCell *registCell = [tableView dequeueReusableCellWithIdentifier:registCellIdentifier];
    
    if (!registCell) {
        
        registCell = [[NSBundle mainBundle] loadNibNamed:registCellIdentifier owner:self options:nil].firstObject;
        
        [tableView registerNib:[UINib nibWithNibName:registCellIdentifier bundle:nil] forCellReuseIdentifier:registCellIdentifier ];
    }
    
    [registCell clickRegist:^(NSString *card, NSString *password) {
       
        [[HXManagerHelper shareHXManagerHelper] registHXServiceWithUsername:card password:password registSuccess:^(NSString *responseData) {
            
            
            
        } registFaile:^(NSString *errorDescription, EMErrorCode errorCode) {
            
            
            
        }];
        
    }];
    
    return registCell;
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
