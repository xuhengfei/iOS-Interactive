//
//  ImageLoadApi.h
//  InteractiveExample
//
//  Created by 周方 on 13-8-3.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFApi.h"

@interface ImageLoadApi : NSObject<XHFApi>

-(id)initWithUrl:(NSString*)url;

@end

@interface ImageLoadParser : NSObject<XHFResponseParser>

@end
