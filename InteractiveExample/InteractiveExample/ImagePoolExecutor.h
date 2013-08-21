//
//  ImagePoolExecutor.h
//  InteractiveExample
//
//  Created by 周方 on 13-8-3.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFSimpleExecutor.h"

@interface ImagePoolExecutor : XHFSimpleExecutor

+(id)shared;


-(UIImage*)loadImageWithUrl:(NSString*)url;

@end
