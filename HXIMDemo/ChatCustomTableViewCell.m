//
//  ChatCustomTableViewCell.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "ChatCustomTableViewCell.h"

@interface ChatCustomTableViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *chatImageView;


@end

@implementation ChatCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (void)layoutSubviews{
    
//    UIImage *backImage;
//    backImage = [UIImage imageNamed:@"气泡"];
//    CGFloat top = 0;
//    CGFloat left = 50;
//    CGFloat bottom = 20;
//    CGFloat right = 50;
//    backImage = [backImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
//    self.chatImageView.image = backImage;
//   
//    CGFloat screen_Width = [UIScreen mainScreen].bounds.size.width;
//    
//    self.chatImageView.frame = CGRectMake(left, 0, screen_Width - 100, 80);

}

@end
