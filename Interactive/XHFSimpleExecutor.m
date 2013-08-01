//
//  SimpleInteractiveExecutor.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-18.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "XHFSimpleExecutor.h"
#import "ASIHTTPRequest.h"
#import "XHFExecutorPlugin.h"
#import "XHFExecutorContext.h"
#import "XHFHandler.h"
#import "XHFSimpleHandler.h"

@implementation XHFSimpleExecutor{
    NSArray *_plugins;
}

- (id)initWithPlugins:(NSArray *)plugins{
    self=[super init];
    if(self){
        if(plugins==nil){
            _plugins=[[NSMutableArray alloc]init];
        }else{
            _plugins=[[NSMutableArray alloc]initWithArray:plugins];
        }
    }
    return self;
}
-(id)execute:(id<XHFApi>)api exception:(NSException *__autoreleasing *)_exception{
    XHFExecutorContext *context=[[XHFExecutorContext alloc]init];
    if(_exception==nil){
        __autoreleasing NSException *ex=nil;
        _exception=&ex;
    }
    return [self execute0:api exception:_exception context:context handler:nil];
}

-(id<XHFHandler>)execute:(id<XHFApi>)api completeOnMainThread:(CompleteCallback)callback{
    id<XHFHandler> handler=[[XHFSimpleHandler alloc]initWithApi:api Request:nil];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setObject:api forKey:@"api"];
    [dict setObject:[callback copy] forKey:@"callback"];
    [dict setObject:handler forKey:@"handler"];
    [self performSelectorInBackground:@selector(background:) withObject:dict];
    return handler;
}
#pragma mark -
#pragma mark private methods
//在后台新线程中执行此方法
-(void)background:(NSDictionary *)dict{
    NSException *ex=nil;
    id<XHFApi> api=[dict objectForKey:@"api"];
    CompleteCallback callback=[dict objectForKey:@"callback"];
    id<XHFHandler> handler=[dict objectForKey:@"handler"];
    id result=[self execute0:api exception:&ex context:[[XHFExecutorContext alloc]init] handler:handler];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:callback forKey:@"callback"];
    if(result!=nil){
        [params setObject:result forKey:@"result"];
    }
    if(ex!=nil){
        [params setObject:ex forKey:@"exception"];
    }
    if(![handler isCanceled]){
        [self performSelectorOnMainThread:@selector(mainThread:) withObject:params waitUntilDone:NO];
    }else{
        NSLog(@"SimpleExecutor handler has canceled , cancel execute callback");
    }
}
//在主线程中执行此方法
-(void)mainThread:(NSDictionary *)params{
    CompleteCallback callback=[params objectForKey:@"callback"];
    id result=[params objectForKey:@"result"];
    NSException *exception=[params objectForKey:@"exception"];
    callback(result,exception);
}

- (id)execute1:(id<XHFApi>)api exception:(NSException **)_exception context:(XHFExecutorContext*)context handler:(id<XHFHandler>)handler{
    id result=nil;
    ASIHTTPRequest *req=[api getHttpRequest];
    if([handler respondsToSelector:@selector(setRequest:)]){
        [handler performSelector:@selector(setRequest:) withObject:req];
    }
    for(id<XHFExecutorPlugin> plugin in _plugins){
        if([plugin respondsToSelector:@selector(preProcess:context:api:)]){
            id r=[plugin preProcess:req context:context api:api];
            if(r!=nil){
                return r;
            }
            if(context.needReplay){
                return nil;
            }
        }
    }
    if([api respondsToSelector:@selector(mock)]){
        result=[api performSelector:@selector(mock)];
    }
    if(result==nil){
        [req startSynchronous];
    }
    for(id<XHFExecutorPlugin> plugin in _plugins){
        if([plugin respondsToSelector:@selector(postProcess:context:api:)]){
            id r=[plugin postProcess:req context:context api:api];
            if(r!=nil){
                return r;
            }
            if(context.needReplay){
                return nil;
            }
        }
    }
    if(result==nil){
        result= [[api getResponseParser]parse:req exception:_exception];
    }
    return result;
}
- (id)execute0:(id<XHFApi>)api exception:(NSException **)_exception context:(XHFExecutorContext*)context handler:(id<XHFHandler>)handler{
    id result=[self execute1:api exception:_exception context:context handler:handler];
    if(context.needReplay){
        context.needReplay=NO;
        result=[self execute1:api exception:_exception context:context handler:handler];
    }
    return result;
}
@end

