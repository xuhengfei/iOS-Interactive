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
- (id)parse:(ASIHTTPRequest *)request error:(NSError * __autoreleasing *)error{
    NSDictionary *data=[NSJSONSerialization JSONObjectWithData:[request.responseString dataUsingEncoding:NSUTF8StringEncoding]options:0 error:error];
    return data;
}

@end
