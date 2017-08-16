//
//  UIViewController+ShowOrHiddenTabbar.m
//  HXIMDemo
//
//  Created by BillBo on 2017/8/14.
//  Copyright © 2017年 BillBo. All rights reserved.
//

#import "UIViewController+ShowOrHiddenTabbar.h"

#import <objc/runtime.h>
#import <Aspects.h>
@implementation UIViewController (ShowOrHiddenTabbar)

+ (void)load {

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        // AOP 面向切片编程
            DebugLog(@"AOP🍎🍎🍎🍎------- \n %@ \n", aspectInfo.instance);
            
        }error:nil];
        
    });
    
}

- (void)hiddenTabbar{
    
    if (self.tabBarController.tabBar.hidden == YES) {
        
        return;
    
    }else{
        
        UIView *contentView;
        
        if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
            
            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
            
        }else{
            
            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
            
        }
        
        contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y, contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
        
        self.tabBarController.tabBar.hidden = YES;
   
    }
    
}


- (void)showTabbar{
    
    if (self.tabBarController.tabBar.hidden == NO) {
    
        return;
    
    }else{
        
        UIView *contentView;
        
        if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
            
            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
        
        else{
            
            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
       
            contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height);
        
            self.tabBarController.tabBar.hidden = NO;
        
        }
   
    }
    
}

@end
