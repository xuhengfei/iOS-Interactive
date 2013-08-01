//
//  SimpleInteractiveExecutor.h
//  InteractiveExample
//
//  Created by 周方 on 13-6-18.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFExecutor.h"
/**
 *
 */
@interface XHFSimpleExecutor : NSObject<XHFExecutor>

- (id)initWithPlugins:(NSArray*)plugins;


@end
