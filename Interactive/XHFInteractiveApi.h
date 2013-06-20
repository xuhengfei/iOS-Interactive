//
//  InteractiveApi.h
//  InteractiveApi
//
//  Created by 周方 on 13-6-10.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASIHTTPRequest;

@protocol XHFResponseParser <NSObject>

-(id)parse:(ASIHTTPRequest *)request;

@end

@protocol XHFInteractiveApi <NSObject>
//获取HTTP请求
-(ASIHTTPRequest *) getHttpRequest;
//获取HTTP请求的返回结果
-(id<XHFResponseParser>) getResponseParser;

@end



