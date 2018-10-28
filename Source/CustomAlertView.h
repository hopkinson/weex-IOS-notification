//
//  CustomAlertView.h
//  AlertView
//
//  Created by 官深宝 on 2018/9/20.
//  Copyright © 2018年 Angie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

+ (void)showAlertViewWithTitle:(NSString *)title content:(NSString *)content avatar:(NSString *)avatar time:(NSString *)time duration:(CGFloat )duration success:(void (^)(void))success; 
@end
