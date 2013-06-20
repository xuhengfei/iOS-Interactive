//
//  SimpleStrategy.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "SimpleExecutor.h"
#import "ASIHTTPRequest.h"

@implementation SimpleExecutor

- (NSString *)execute:(id<XHFInteractiveApi>)api{
    ASIHTTPRequest *request=[api getHttpRequest];
    [request startSynchronous];
    return request.responseString;
}

@end
