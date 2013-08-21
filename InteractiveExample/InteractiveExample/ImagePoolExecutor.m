//
//  ImagePoolExecutor.m
//  InteractiveExample
//
//  Created by 周方 on 13-8-3.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "ImagePoolExecutor.h"
#import "ImageCachePlugin.h"
#import "ImageLoadApi.h"

@implementation ImagePoolExecutor

+(id)shared{
    static ImagePoolExecutor *executor;
    if(executor==nil){
        executor=[[ImagePoolExecutor alloc]init];
    }
    return executor;
}

-(id)init{
    self=[super initWithPlugins:[NSArray arrayWithObject:[[ImageCachePlugin alloc]init]]];
    if(self){
        
    }
    return self;
}

-(UIImage *)loadImageWithUrl:(NSString *)url{
    ImageLoadApi *api=[[ImageLoadApi alloc]initWithUrl:url];
    return [self execute:api error:nil];
}

@end
