//
//  TOPApi.h
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFInteractiveApi.h"

@interface TOPApi : NSObject<XHFInteractiveApi>{
    NSMutableDictionary *_params;
}

@property (nonatomic,retain) NSString *method;

-(id)initWithMethod:(NSString*)method;

@end
