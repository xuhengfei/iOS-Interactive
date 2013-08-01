//
//  XHFSimpleHandler.m
//  InteractiveExample
//
//  Created by 周方 on 13-8-1.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "XHFSimpleHandler.h"
#import "XHFApi.h"
#import "ASIHttpRequest.h"
@implementation XHFSimpleHandler{
    id<XHFApi> _api;
    ASIHTTPRequest *_request;
    BOOL _canceled;
}
-(id)initWithApi:(id<XHFApi>)api Request:(ASIHTTPRequest *)request{
    self=[super init];
    if(self){
        _api=api;
        _request=request;
        _canceled=NO;
    }
    return self;
}

-(BOOL)isCanceled{
    return _canceled;
}

-(BOOL)isDone{
    if(_request==nil){
        return NO;
    }
    return [_request isFinished];
}
-(void)cancel{
    _canceled=YES;
    [_request clearDelegatesAndCancel];
}

-(void)setRequest:(ASIHTTPRequest*)req{
    _request=req;
}

-(NSString *)description{
    return [_request.url absoluteString];
}

@end
