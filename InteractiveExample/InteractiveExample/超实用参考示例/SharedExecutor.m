//
//  SharedExecutor.m
//  InteractiveExample
//
//  Created by xuhengfei on 14-1-16.
//  Copyright (c) 2014年 xuhengfei. All rights reserved.
//

#import "SharedExecutor.h"
#import "LoginPlugin.h"

@implementation SharedExecutor
+(id<XHFExecutor>)shared{
    static SharedExecutor *executor;
    if(executor==nil){
        //注意，在构造这个单例时，需要配置好插件
        executor=[[SharedExecutor alloc]initWithPlugins:[NSArray arrayWithObject:[[LoginPlugin alloc]init]]];
    }
    return executor;
}
@end