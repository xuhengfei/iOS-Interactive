//
//  XHFSimpleHandler.h
//  InteractiveExample
//
//  Created by 周方 on 13-8-1.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFHandler.h"
#import "XHFApi.h"
@class ASIHTTPRequest;


@interface XHFSimpleHandler : NSObject <XHFHandler>

-(id)initWithApi:(id<XHFApi>)api Request:(ASIHTTPRequest*)request;

@end
