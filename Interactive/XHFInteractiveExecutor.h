//
//  InteractiveStrategy.h
//  InteractiveApi
//
//  Created by 周方 on 13-6-13.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFInteractiveApi.h"

@protocol XHFInteractiveExecutor <NSObject>

@required
-(id)execute:(id<XHFInteractiveApi>)api;

@end
