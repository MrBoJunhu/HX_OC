//
//  ChatListCustomCell.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "ChatListCustomCell.h"

@interface ChatListCustomCell()

@property (strong, nonatomic) IBOutlet UIButton *photo;

@property (strong, nonatomic) IBOutlet UILabel *titleLB;

@property (strong, nonatomic) IBOutlet UILabel *timeLB;

@property (strong, nonatomic) IBOutlet UILabel *msgLB;


@end

@implementation ChatListCustomCell

- (void)awakeFromNib {
   
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  
    [super setSelected:selected animated:animated];

}

- (void)reloadChatListCustomCellWithTitle:(NSString *)title msg:(NSString *)msg time:(NSString *)time{
    
    self.timeLB.text = title;
    
    self.msgLB.text = msg;
    
    self.timeLB.text = time;
    
}

@end
