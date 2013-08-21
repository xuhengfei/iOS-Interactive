//
//  ImageCachePlugin.m
//  InteractiveExample
//
//  Created by 周方 on 13-8-3.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "ImageCachePlugin.h"
#import "XHFLocalCache.h"
#import "ImageLoadApi.h"

@implementation ImageCachePlugin{
    XHFLocalCache *_cache;
}

-(id)init{
    self=[super init];
    if(self){
        _cache=[XHFLocalCache shared];
    }
    return self;
}

-(id)preProcess:(ASIHTTPRequest *)request context:(XHFExecutorContext *)context api:(id)api{
    if([api isKindOfClass:[ImageLoadApi class]]){
        NSString *url=request.url.absoluteString;
        NSData *data=[_cache objectForKey:url];
        if(data!=nil){
            return [[UIImage alloc]initWithData:data];
        }
    }
    return nil;
}

-(id)postProcess:(ASIHTTPRequest *)request context:(XHFExecutorContext *)context api:(id<XHFApi>)api{
    if([api isKindOfClass:[ImageLoadApi class]]){
        [_cache setObject:request.responseData forKey:request.url.absoluteString];
    }
    return nil;
}

@end
