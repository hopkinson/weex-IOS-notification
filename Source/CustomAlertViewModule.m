//
//  TestModule.m
//  WeexEros
//
//  Created by 官深宝 on 2018/9/20.
//  Copyright © 2018年 benmu. All rights reserved.
//

#import "CustomAlertViewModule.h"
#import "CustomAlertView.h"


@implementation CustomAlertViewModule
@synthesize weexInstance;
// 将方法暴露出去
WX_EXPORT_METHOD(@selector(showAlertViewWithTitle:content:avatar:time:duration:))

// 实现 Module 方法
-(void)showAlertViewWithTitle:(NSString *)title content:(NSString *)content avatar:(NSString *)avatar time:(NSString *)time duration:(CGFloat )duration {
    [CustomAlertView showAlertViewWithTitle:title content:content avatar:avatar time:time duration:duration success:nil];
}
@end
