//
//  XHFExecutorContext.h
//  InteractiveExample
//
//  Created by 周方 on 13-6-27.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//


@interface XHFExecutorContext : NSObject

@property (nonatomic,readonly) NSMutableDictionary *attribute;
//是否需要重播
@property (nonatomic,assign) BOOL needReplay;

@end
