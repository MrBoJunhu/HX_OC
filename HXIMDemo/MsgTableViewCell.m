//
//  MsgTableViewCell.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/8.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "MsgTableViewCell.h"

@interface MsgTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel *titleLB;

@property (strong, nonatomic) IBOutlet UILabel *msgLB;

@property (nonatomic, copy) clickAgrBlock agreeBlock;

@property (nonatomic, copy) clickDisAgrBlock disagreeBlock;

@end

@implementation MsgTableViewCell

- (void)awakeFromNib {
   
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (void)reloadMsgTableViewCellUIWithTitle:(NSString *)title msg:(NSString *)msg clickAgree:(clickAgrBlock)agree disagree:(clickDisAgrBlock)disagree{
    
    self.titleLB.text = title;
    
    self.msgLB.text = msg;
    
    self.agreeBlock = agree;
    
    self.disagreeBlock = disagree;
    
    
}
- (IBAction)agreeAct:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 101) {
        
        if (self.agreeBlock) {
            self.agreeBlock();
        }
        
    }else if (btn.tag == 102){
        if (self.disagreeBlock) {
            self.disagreeBlock();
        }
    }
    
}

@end
