//
//  ImageDownloadApi.h
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XHFInteractiveApi.h"
#import "SimpleHttpGetApi.h"
@interface ImageDownloadApi : SimpleHttpGetApi<XHFInteractiveApi>

@end

@interface ImageDownloadParser : NSObject<XHFResponseParser>

@end
