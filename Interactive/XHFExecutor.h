//
//  InteractiveStrategy.h
//  InteractiveApi
//
//  Created by 周方 on 13-6-13.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFApi.h"
#import "XHFHandler.h"

typedef  void(^CompleteCallback)(id,NSException*);

@protocol XHFExecutor <NSObject>

@required

//执行一个Api，同步的方式返回一个解析后的对象
-(id)execute:(id<XHFApi>)api exception:(NSException*__autoreleasing*)exception;
//执行一个Api，异步的方式在主线程中进行回调
-(id<XHFHandler>)execute:(id<XHFApi>)api completeOnMainThread:(CompleteCallback)callback;
@end

