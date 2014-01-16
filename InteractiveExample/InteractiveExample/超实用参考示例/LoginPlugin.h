//
//  LoginPlugin.h
//  InteractiveExample
//
//  自动登陆插件
//  与服务器端配合，当服务器返回未登录状态时
//  该插件会调用登陆界面，要求用户进行登陆
//  登陆成功后，会对请求进行一次重试
//  整个过程对 使用者来说是透明的，无须关注未登录的情况
//
//  Created by xuhengfei on 14-1-16.
//  Copyright (c) 2014年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFExecutorPlugin.h"

@interface LoginPlugin : NSObject<XHFExecutorPlugin>

@end
