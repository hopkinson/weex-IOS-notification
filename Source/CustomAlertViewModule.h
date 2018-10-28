//
//  TestModule.h
//  WeexEros
//
//  Created by 官深宝 on 2018/9/20.
//  Copyright © 2018年 benmu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXModuleProtocol.h"

#import <WeexPluginLoader/WeexPluginLoader.h>
// 第一个参数为暴露给 js 端 Module 的名字，
// 第二个参数为你 Module 的类名
WX_PlUGIN_EXPORT_MODULE(CustomAlertViewModule, CustomAlertViewModule)

@interface CustomAlertViewModule : NSObject<WXModuleProtocol>

@end
