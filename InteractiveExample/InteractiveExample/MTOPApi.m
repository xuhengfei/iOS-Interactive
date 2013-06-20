//
//  MTOPApi.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "MTOPApi.h"

@implementation MTOPApi

-(id)initWithMethod:(NSString*)method{
    self=[super initWithMethod:method];
    if(self){
        [_params setObject:method forKey:@"api"];
        [_params setObject:@"*" forKey:@"v"];
        [_params setObject:@"" forKey:@"ttid"];
        [_params setObject:@"md5" forKey:@"authType"];
        [_params setObject:[[[UIDevice currentDevice] uniqueIdentifier] ?:@""] forKey:@"imei"];
        
        [super addParam:method forKey:@"api"];
        [super addParam:@"*" forKey:@"v"];
        [super addParam:[TOP wapTTID] forKey:@"ttid"];
        [super addParam:@"md5" forKey:@"authType"];
        [super addParam:[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier] ?: @"1234567890" forKey:@"imei"];
        [super addParam:@"0987654321" forKey:@"imsi"];
        [super addParam:[TOP appKey] forKey:@"appKey"];
    }
    return self;
}
@end
