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
@required
-(id)parse:(ASIHTTPRequest*)request error:(NSError*__autoreleasing*)error;

@end

@protocol XHFApi <NSObject>

@required
//获取HTTP请求
-(ASIHTTPRequest*) getHttpRequest;
//获取HTTP请求返回结果的解析器
-(id<XHFResponseParser>) getResponseParser;


@optional
//模拟Api的返回结果
//如果返回为nil，则认为不进行mock
-(id)mock;
@end



