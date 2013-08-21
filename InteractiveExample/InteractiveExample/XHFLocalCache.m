//
//  XHFLocalCache.m
//  InteractiveExample
//
//  Created by 周方 on 13-8-3.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "XHFLocalCache.h"
#import <CommonCrypto/CommonDigest.h>

static NSMutableDictionary *_singletonPool;

@implementation XHFLocalCache{
    XHFLocalCacheConfig *_config;
}


+(void)initialize{
    _singletonPool=[[NSMutableDictionary alloc]init];
}

+ (XHFLocalCache *)shared{
    NSString* folder=@"_XHFLocalCache";
    if([_singletonPool objectForKey:folder]!=nil){
        return [_singletonPool objectForKey:folder];
    }
    XHFLocalCacheConfig *config=[[XHFLocalCacheConfig alloc]init];
    config.folder=folder;
    XHFLocalCache *cache=[[XHFLocalCache alloc]initWithConfig:config];
    return cache;
}

+(XHFLocalCache *)sharedWithPath:(NSString *)path{
    return nil;
}
-(XHFLocalCache *)initWithConfig:(XHFLocalCacheConfig *)config{
    self=[super init];
    if(self){
        XHFLocalCache *instance=[_singletonPool objectForKey:config.folder];
        if(instance!=nil){
            return nil;
        }
        [_singletonPool setObject:self forKey:config.folder];
        
        _config=config;
        if(_config.enableMemCache){
            _cache=[[NSCache alloc]init];
            [_cache setCountLimit:*(_config.maxMemFiles)];
            [_cache setTotalCostLimit:*(_config.maxMemSpace)];
        }
        
        
        NSString *temp=NSTemporaryDirectory();
        NSString *fullpath=[temp stringByAppendingPathComponent:_config.folder];
        NSFileManager *fm=[NSFileManager defaultManager];
        BOOL ok=YES;
        BOOL exist=[fm fileExistsAtPath:fullpath isDirectory:&ok];
        if(!exist){
            [[NSFileManager defaultManager]createDirectoryAtPath:fullpath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}

- (NSData*)objectForKey:(NSString*)key{
    id obj=[_cache objectForKey:key];
    if(obj!=nil){
        return obj;
    }
    NSString *full=[self getFullPath:key];
    if([[NSFileManager defaultManager]fileExistsAtPath:full]){
        NSFileHandle *handler=[NSFileHandle fileHandleForReadingAtPath:full];
        NSData *data=[handler readDataToEndOfFile];
        return data;
    }else{
        return nil;
    }
}
- (void)setObject:(NSData*)obj forKey:(NSString*)key{
    NSData *cached=[_cache objectForKey:key];
    if(cached!=nil){
        if([cached isEqualToData:obj]){
            return;
        }
        [self setFileCache:obj forKey:key];
    }else{
        [_cache setObject:obj forKey:key];
        [self setFileCache:obj forKey:key];
    }
}
- (void)removeObjectForKey:(NSString*)key{
    [_cache removeObjectForKey:key];
    [self deleteFile:key];
}
- (void)removeAllObjects{
    [_cache removeAllObjects];
    [self deleteAllFiles];
}
-(void)setMemCache:(NSData*)data forKey:(NSString*)key{
    [_cache setObject:data forKey:key];
    //TODO mem cache expire time
}
-(NSData*)getMemCache:(NSString*)key{
    return [_cache objectForKey:key];
}
-(void)setFileCache:(NSData*)data forKey:(NSString*)key{
    NSString *fullPath=[self getFullPath:key];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [data writeToFile:fullPath atomically:YES];
        //文件数判断
        //磁盘空间判断
    });
}
-(NSData*)getFileCache:(NSString*)key{
    NSString *fullPath=[self getFullPath:key];
    if([[NSFileManager defaultManager]fileExistsAtPath:fullPath]){
        if(_config.expireTime>0){
            NSDictionary *attr=[[NSFileManager defaultManager]attributesOfItemAtPath:fullPath error:nil];
            NSTimeInterval create=[attr.fileCreationDate timeIntervalSince1970];
            NSTimeInterval now=[[NSDate date]timeIntervalSince1970];
            if(now>(create+*(_config.expireTime))){//是否过期
                [self deleteFile:key];
                return nil;
            }
        }
        NSFileHandle *handler=[NSFileHandle fileHandleForReadingAtPath:fullPath];
        NSData *data=[handler readDataToEndOfFile];
        return data;
    }else{
        return nil;
    }
}
//get folder space
-(NSInteger)folderSpaceCount{
    NSFileManager *fileManager =[NSFileManager defaultManager];
    
    NSInteger size=0;
    NSString *folderPath=[self getFolderPath];
    NSArray* array = [fileManager contentsOfDirectoryAtPath:folderPath error:nil];
    for(int i = 0; i<[array count]; i++){
        NSString *fullPath = [folderPath stringByAppendingPathComponent:[array objectAtIndex:i]];
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:nil])){
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize;
        }
    }
    return size;
}

-(void)deleteAllFiles{
    NSString *folder=[NSTemporaryDirectory() stringByAppendingPathComponent:_config.folder];
    NSArray *files=[[NSFileManager defaultManager]contentsOfDirectoryAtPath:folder error:nil];
    for(NSString *filename in files){
        NSString *fullPath=[folder stringByAppendingPathComponent:filename];
        if([[NSFileManager defaultManager]fileExistsAtPath:fullPath]){
            [[NSFileManager defaultManager]removeItemAtPath:fullPath error:nil];
        }
    }
}

-(void)deleteFile:(NSString*)key{
    NSString *fullPath=[self getFullPath:key];
    if([[NSFileManager defaultManager]fileExistsAtPath:fullPath]){
        [[NSFileManager defaultManager]removeItemAtPath:fullPath error:nil];
    }
}


-(NSString*)getFolderPath{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:_config.folder];
}

-(NSString*)getFullPath:(NSString*)key{
    NSString *tempRoot= NSTemporaryDirectory();
    NSString *fileKey=[self.class md5HexDigest:key];
    NSString *full=[[tempRoot stringByAppendingPathComponent:_config.folder]stringByAppendingPathComponent:fileKey];
    return full;
}

+ (NSString *)md5HexDigest:(NSString*)input{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}
@end


@implementation XHFLocalCacheConfig

-(id)initWithFolder:(NSString *)folder{
    self=[self init];
    if(self){
        self.folder=folder;
    }
    return self;
}
-(id)init{
    self=[super init];
    if(self){
        self.enableMemCache=NO;
        self.maxSpace=0;
        self.maxFiles=0;
        self.maxMemFiles=0;
        self.maxMemSpace=0;
    }
    return self;
}

@end