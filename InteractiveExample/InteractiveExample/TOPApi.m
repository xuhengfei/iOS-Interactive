//
//  TOPApi.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "TOPApi.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

#define CC_MD5_DIGEST_LENGTH 16

#define SignKey @"sign"

@implementation TOPApi

-(id)initWithMethod:(NSString*)method{
    self=[super init];
    if(self){
        _params=[[NSMutableDictionary alloc]init];
        [_params setObject:method forKey:@"method"];
    }
    return self;
}

-(ASIHTTPRequest *)getHttpRequest{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@""]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timestamp = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    [request setPostValue:timestamp forKey:@"t"];
    //sign
    [request setPostValue:[self md5:[[[_params allKeys] componentsJoinedByString:@""] dataUsingEncoding:NSUTF8StringEncoding]] forKey:SignKey];
    
    return request;
}

- (NSString *)md5:(NSData*)data {
    const void *ptrData = [data bytes];
    
	unsigned char ret[CC_MD5_DIGEST_LENGTH];
    
	CC_MD5( ptrData, [data length], ret );
    
    NSData *md5data = [NSData dataWithBytes:ret length:CC_MD5_DIGEST_LENGTH];
    
    
    const unsigned char *result = (const unsigned char *)[md5data bytes];
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
