//
//  TestViewController.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/8.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tbv;

@end

@implementation TestViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"测试";
    
    self.tbv = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tbv.delegate = self;
    
    self.tbv.dataSource = self;
    
    [self.view addSubview:self.tbv];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    self.tbv.frame = self.view.frame;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
       
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行", indexPath.row];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewRowAction *act1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"增加" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    act1.backgroundColor = [UIColor lightGrayColor];
    
    UITableViewRowAction *act2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    act2.backgroundColor = [UIColor cyanColor];
    
    return @[act1, act2];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end
