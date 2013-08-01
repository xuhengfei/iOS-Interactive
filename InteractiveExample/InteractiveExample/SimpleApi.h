//
//  SimpleApi.h
//  InteractiveExample
//
//  Created by 周方 on 13-8-1.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFApi.h"

@interface SimpleApi : NSObject <XHFApi>

-(id)initWithUrl:(NSString*)url;

@end


@interface SimpleParser : NSObject <XHFResponseParser>



@end