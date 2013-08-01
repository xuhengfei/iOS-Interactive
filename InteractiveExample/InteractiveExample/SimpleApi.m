//
//  SimpleApi.m
//  InteractiveExample
//
//  Created by 周方 on 13-8-1.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "SimpleApi.h"
#import "ASIHTTPRequest.h"

@implementation SimpleApi{
    NSString *_url;
}

-(id)initWithUrl:(NSString *)url{
    self=[super init];
    if(self){
        _url=url;
    }
    return self;
}

-(ASIHTTPRequest *)getHttpRequest{
    ASIHTTPRequest *req=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:_url]];
    return req;
}
-(id<XHFResponseParser>)getResponseParser{
    return [[SimpleParser alloc]init];
}

@end


@implementation SimpleParser

-(id)parse:(ASIHTTPRequest *)request exception:(NSException *__autoreleasing *)exception{
    return request.responseString;
}
@end