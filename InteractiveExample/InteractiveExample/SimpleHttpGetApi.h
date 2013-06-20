//
//  SimpleHttpGetApi.h
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFInteractiveApi.h"

@interface SimpleHttpGetApi : NSObject<XHFInteractiveApi>{
    ASIHTTPRequest *_request;
}

-(id)initWithUrl:(NSString *)url;

@end


@interface SimpleResponseParser : NSObject<XHFResponseParser>

@end