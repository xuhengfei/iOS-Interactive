//
//  XHFHandler.h
//  InteractiveExample
//
//  Created by 周方 on 13-8-1.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XHFHandler <NSObject>

-(BOOL)isCanceled;

-(BOOL)isDone;

-(void)cancel;

@end
