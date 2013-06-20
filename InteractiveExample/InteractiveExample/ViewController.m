//
//  ViewController.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "ViewController.h"
#import "SimpleHttpGetApi.h"
#import "SimpleExecutor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SimpleHttpGetApi *api=[[SimpleHttpGetApi alloc]initWithUrl:@"http://www.baidu.com"];
    SimpleExecutor *stratgy=[[SimpleExecutor alloc]init];
    NSString *result=[stratgy execute:api];
    NSLog(@"%@",result);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
