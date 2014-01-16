//
//  SharedExecutor.h
//  InteractiveExample
//
//  一般情况下每个项目都会对 XHFSimpleExecutor 进行一次简单的包装
//  使用一个静态示例来处理网络请求，无须每次都创建
//  将你项目里需要用到的 Plugin 插件放入 这个 SharedExecutor 中
//
//  Created by xuhengfei on 14-1-16.
//  Copyright (c) 2014年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFSimpleExecutor.h"

@interface SharedExecutor : XHFSimpleExecutor
+(id<XHFExecutor>)shared;
@end
