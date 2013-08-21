//
//  XHFInteractivePlugin.h
//  InteractiveExample
//
//  Created by 周方 on 13-6-27.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFExecutorContext.h"
#import "ASIHTTPRequest.h"
#import "XHFApi.h"

@protocol XHFExecutorPlugin <NSObject>

@optional

-(id)preProcess:(ASIHTTPRequest *)request context:(XHFExecutorContext *)context api:(id<XHFApi>)api;

-(id)postProcess:(ASIHTTPRequest *)request context:(XHFExecutorContext *)context api:(id<XHFApi>)api;

@end
