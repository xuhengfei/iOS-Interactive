//
//  ImageDownloadApi.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "ImageDownloadApi.h"
#import "ASIHTTPRequest.h"

@implementation ImageDownloadApi

- (ASIHTTPRequest *)getHttpRequest{
    return _request;
}

- (id<XHFResponseParser>)getResponseParser{
    return [[[ImageDownloadParser alloc]init]autorelease];
}

@end

@implementation ImageDownloadParser

- (UIImage *)parse:(ASIHTTPRequest *)request{
    NSData *data=[request.responseData autorelease];
    return [[UIImage imageWithData:data]autorelease];
}

@end
