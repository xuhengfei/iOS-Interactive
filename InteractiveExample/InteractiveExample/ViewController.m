//
//  ViewController.m
//  InteractiveExample
//
//  Created by 周方 on 13-6-14.
//  Copyright (c) 2013年 xuhengfei. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "XHFApi.h"
#import "XHFExecutor.h"
#import "XHFSimpleExecutor.h"
#import "XHFExecutorPlugin.h"
#import "XHFExecutorContext.h"
#import "SimpleApi.h"
#import "ImagePoolViewController.h"
#import "ASIHTTPRequest.h"
#import "SharedExecutor.h"

@interface ViewController ()

@end

@implementation ViewController{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scroll];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(10, 50, 300, 30);
    [button setTitle:@"异步加载百度网页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(asyncLoad) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame=CGRectMake(10, 100, 300, 30);
    [btn2 setTitle:@"同步加载百度网页" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(syncLoad) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn2];
    
//    ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://www.taobao.com"]];
//    [req startSynchronous];
//    NSLog(@"%@",req.responseString);
}

-(void)syncLoad{
    SimpleApi *api=[[SimpleApi alloc]initWithUrl:@"http://www.baidu.com"];
    NSError *error=nil;
    NSString *result=[[SharedExecutor shared]execute:api error:&error];
    if(error==nil){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"网页内容" message:result delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
-(void)asyncLoad{
    SimpleApi *api=[[SimpleApi alloc]initWithUrl:@"http://www.baidu.com"];
    [[SharedExecutor shared]execute:api completeOnMainThread:^(NSString* result, NSError *error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"网页内容" message:result delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end



