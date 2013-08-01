//
//  XHFJsonParser.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-19.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "XHFJsonParser.h"
#import "ASIHTTPRequest.h"

@implementation XHFJsonParser
- (id)parse:(ASIHTTPRequest *)request exception:(NSException * __autoreleasing *)exception{
    NSDictionary *data=[NSJSONSerialization JSONObjectWithData:[request.responseString dataUsingEncoding:NSUTF8StringEncoding]options:0 error:nil];
    if(data==nil){
        *exception=[[NSException alloc]initWithName:@"JSON解析出错" reason:@"request.responseString 无法解析成NSDictionary对象" userInfo:nil];
    }
    return data;
}

@end
