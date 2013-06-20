//
//  GetUploadTokenApi.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "GetUploadTokenApi.h"

@implementation GetUploadTokenApi

- (id)init{
    self=[super initWithMethod:@"com.taobao.mtop.getUploadFileToken"];
    if(self){
        [request removeTopParam:@"v"];
        [request addTopParam:@"1.0" forKey:@"v"];
        [request sendRequest];
    }
    return self;
}

@end
