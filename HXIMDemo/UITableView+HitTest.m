//
//  UITableView+HitTest.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/2.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "UITableView+HitTest.h"

@implementation UITableView (HitTest)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    id view = [super hitTest:point withEvent:event];
    
    if (![view isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            return view;
        }
        
        return self;
    }else{
        
        return view;
    }
    
    
}

@end
