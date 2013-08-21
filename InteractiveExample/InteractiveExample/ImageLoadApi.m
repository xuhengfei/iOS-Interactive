//
//  ImageLoadApi.m
//  InteractiveExample
//
//  Created by 周方 on 13-8-3.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "ImageLoadApi.h"
#import "ASIHTTPRequest.h"

@implementation ImageLoadApi{
    NSString* _url;
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
    return [[ImageLoadParser alloc]init];
}

@end

@implementation ImageLoadParser

-(id)parse:(ASIHTTPRequest *)request error:(NSError **)error{
    UIImage *image=[[UIImage alloc]initWithData:request.responseData];
    return image;
}

@end
