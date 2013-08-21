//
//  XHFLocalCache.h
//  InteractiveExample
//
//  Created by 周方 on 13-8-3.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XHFLocalCacheConfig;

@interface XHFLocalCache : NSObject{
    @private
    NSCache *_cache;
}

+(XHFLocalCache*)sharedWithPath:(NSString*)path;

+(XHFLocalCache*)shared;

-(XHFLocalCache*)initWithConfig:(XHFLocalCacheConfig*)config;

- (NSData*)objectForKey:(NSString*)key;
- (void)setObject:(NSData*)obj forKey:(NSString*)key;
- (void)removeObjectForKey:(NSString*)key;
- (void)removeAllObjects;

@end


@interface XHFLocalCacheConfig : NSObject

@property (nonatomic,copy) NSString *folder;

@property (nonatomic,assign) BOOL enableMemCache;//default to NO

@property (nonatomic,assign) NSUInteger *maxSpace;//default to unlimit

@property (nonatomic,assign) NSUInteger *maxFiles;//default to unlimit

@property (nonatomic,assign) NSUInteger *maxMemFiles;//default to unlimit

@property (nonatomic,assign) NSUInteger *maxMemSpace;//default to unlimit

@property (nonatomic,assign) NSUInteger *expireTime;//default to no expire time

-(id)initWithFolder:(NSString*)folder;

@end