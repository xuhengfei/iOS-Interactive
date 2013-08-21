//
//  ImagePoolViewController.m
//  InteractiveExample
//
//  Created by 周方 on 13-8-3.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "ImagePoolViewController.h"
#import "ImagePoolExecutor.h"
#import <CommonCrypto/CommonDigest.h>
#import "XHFLocalCache.h"

@interface ImagePoolViewController ()

@end

@implementation ImagePoolViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *s=@"http://img04.taobaocdn.com/imgextra/i4/1646271253/T2QFvLXe8XXXXXXXXX_!!1646271253.jpg";
    
    UIImage *image=[[ImagePoolExecutor shared]loadImageWithUrl:s];
    
    UIImageView *view=[[UIImageView alloc]initWithImage:image];
    [self.view addSubview:view];
    
}

@end
