//
//  LoginPlugin.m
//  InteractiveExample
//
//  Created by xuhengfei on 14-1-16.
//  Copyright (c) 2014年 xuhengfei. All rights reserved.
//

#import "LoginPlugin.h"
#import "SharedExecutor.h"

@implementation LoginPlugin

//前置插件，也可以在这里进行一次预判，看是否需要登陆
-(id)preProcess:(ASIHTTPRequest *)request context:(XHFExecutorContext *)context api:(id<XHFApi>)api{
    return nil;
}
//后置处理，如果服务器返回需要登陆，则调用登陆界面进行登陆
-(id)postProcess:(ASIHTTPRequest *)request context:(XHFExecutorContext *)context api:(id<XHFApi>)api{
    
    NSError *error=request.error;
    if(error!=nil){
        //如果服务器端提示未登陆  此处根据业务自行进行修改
        if([error.domain isEqualToString:@"UserNotLogin"]){
            //进行自动登陆
            //参考示例如下，自行根据业务实现
        
//            AutoLoginApi *autoLogin=[[AutoLoginApi alloc]initWithXXX];
//            NSError *error=nil;
//            [[SharedExecutor shared]execute:autoLogin error:&error];
//            if(error==nil){
//                context.needReplay=YES;
//                return nil;
//            }

            //如果设置了忽略，则不弹出登录框 （有时的需求是：如果发现未登录，就放弃此次请求，不弹出登陆框）
            if([api respondsToSelector:@selector(ignoreLogin)]){
                BOOL ignore=[api performSelector:@selector(ignoreLogin)];
                if(ignore){
                    return nil;
                }
            }
            
            __block BOOL complete=NO;
            __block NSInteger loginValue=-1;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIViewController *root=[[UIApplication sharedApplication] keyWindow].rootViewController;
                //调用登陆界面，要求用户登陆
//                GYLoginViewController *login=[[GYLoginViewController alloc]initWithCallback:^(NSInteger value) {
//                    loginValue=value;
//                    complete=YES;
//                }];
//                GYPresentNavController *nav=[[GYPresentNavController alloc]initWithRootViewController:login];
//                
//                [root presentViewController:nav animated:YES completion:nil];
            });
            while (!complete) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
            if(loginValue==1){
                context.needReplay=YES;
            }else if(loginValue==0){//用户取消登陆
                //自行实现 用户取消登陆 行为的格式约定
//                GYDefinedError *de=[[GYDefinedError alloc]initWithDomain:@"用户取消登陆" code:0 userInfo:nil];
//                de.errorCode=ErrorCodes_UserNotLogin;
//                de.message=de.domain;
//                return de;
                return nil;
            }
        }
    }
    return nil;
}

@end