//
//  AddNewFriendViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/7.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "AddNewFriendViewController.h"

@interface AddNewFriendViewController ()<UISearchBarDelegate>

@end

@implementation AddNewFriendViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"添加好友";
    
    CGFloat searchView_Width = self.view.frame.size.width;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, searchView_Width, 40)];
    
    searchBar.placeholder = @"请输入搜索用户名";
    
    searchBar.barStyle = UIBarStyleDefault;
    
    searchBar.delegate = self;
    
    searchBar.showsCancelButton = YES;
    
    [self.view addSubview:searchBar];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
 
    
    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
   
    
    
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0){
    
    
    return YES;
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    DebugLog(@"%@", searchBar.text);
    
    NSString *userName = searchBar.text;
    
    [[HXManagerHelper shareHXManagerHelper] addNewFriendWithUsername:userName success:^{
    
        
        
    } faile:^(NSString *arrorDescription, EMErrorCode errorCode) {
       
        
        
    }];
    
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED{
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED{
 
    
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED{
    
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    
    
}



@end
