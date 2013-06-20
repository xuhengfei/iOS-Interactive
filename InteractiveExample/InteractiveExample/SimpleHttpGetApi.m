//
//  SimpleHttpGetApi.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "SimpleHttpGetApi.h"
#import "ASIHTTPRequest.h"

@implementation SimpleHttpGetApi

- (id)initWithUrl:(NSString *)url{
    self=[super init];
    if(self){
        _request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    }
    return self;
}

- (ASIHTTPRequest *)getHttpRequest{
    return _request;
}

- (id<XHFResponseParser>)getResponseParser{
    return [[SimpleResponseParser alloc]init];
}

- (void)dealloc{
    [_request release];
    [super dealloc];
}
@end

@implementation SimpleResponseParser

- (NSString*)parse:(ASIHTTPRequest *)request{
    return request.responseString;
}

@end