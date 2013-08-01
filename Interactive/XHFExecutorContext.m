//
//  XHFExecutorContext.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-27.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "XHFExecutorContext.h"

@implementation XHFExecutorContext

-(id)init{
    self=[super init];
    if(self){
        _attribute=[[NSMutableDictionary alloc]init];
    }
    return self;
}

@end
