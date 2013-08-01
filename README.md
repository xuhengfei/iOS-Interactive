
Interactive is a basic network framework  
We provide core Protocols and a common implementation  

More Imagination ideas are waiting for you to implementation

Features:  
***Simple***: make http process simple  
***Mock*** : simple http response mock (not just string ,but object)  
***Reuseable and Transferable*** : requests will be wapper as a Api  
***Plugin*** : support preProcess and postProcess and transparent to invoker  
***Expansibility*** : all Protocol can be implementation by yourself  


Interactive have 4 Core Protocols, the relationship like below image:    
<img src="http://xuhengfei.com/assets/images/interaceive/protocols.png" />

***XHFApi*** (we call *Api* below)  
```objective-c
@protocol XHFApi <NSObject>
@required
//provide a request base on ASIHTTPRequest  
-(ASIHTTPRequest*) getHttpRequest;
//provide a parser which need to implement XHFResponseParser
-(id<XHFResponseParser>) getResponseParser;

@optional
//mock Api response,not just string ,but business object
-(id)mock;
@end
```
Api define 2 Object: Request and Parser  
Request:  Api need to build a Request  
Parser: Api need to build a Parser,it will be used to parse http response  

***XHFExecutor*** (we call *Executor* below)  
```objective-c
@protocol XHFExecutor <NSObject>
@required
//execute a Api with Sync Mode
-(id)execute:(id<XHFApi>)api exception:(NSException*__autoreleasing*)exception;
//execute a Api with Async Mode and callback in MainThread
-(id<XHFHandler>)execute:(id<XHFApi>)api completeOnMainThread:(CompleteCallback)callback;
@end
```
Executor have only one operate: execute  
Executor can execute a Api,and return a result,pay attention ,this result is not a string,but a bussiness object which is parsered from response  

Above 2 Protocols ,we can give a sample with Pseudocode :  
```objective-c
SomeApi *api=[[SomeApi alloc]initWithUrl:@"http://www.google.com"];
SimpleExecutor *executor=[[SimpleExecutor alloc]init];
__autoreleasing NSException *exception=nil;
id result=[executor execute:api exception:&exception];
if(exception!=nil){
      //Business Code
}
```

***XHFHandler*** (we call *Handler* below)  
```objective-c
@protocol XHFHandler <NSObject>

-(BOOL)isCanceled;

-(BOOL)isDone;

-(void)cancel;

@end
```
When you execute a Api in Async Mode, you can receive a Handler,using Handler,you can cancel this request,or track the status of this request  

***XHFExecutorPlugin*** (we call *Plugin* below)  
```objective-c
@protocol XHFExecutorPlugin <NSObject>
@optional
//this will be invoke before the request send
-(id)preProcess:(ASIHTTPRequest *)request context:(XHFExecutorContext *)context api:(id<XHFApi>)api;
//this will be invoke after the response has received
-(id)postProcess:(ASIHTTPRequest *)request context:(XHFExecutorContext *)context api:(id<XHFApi>)api;

@end
```
Plugin is a very useful Feature  
You can do something before or after request send,and this will be transparent for Api invoker  
Both preProcess and postProcess ,we give Classic Case  
Case1: Http Request Cache  
Sometimes we offen need to cache some type of http request  
In this case you can write a Plugin and implement preProcess method 

Case2: Login Session Invalid  
Some Http Request need login session,sometimes session will be out of time  
If we send Http Request Direct and return , it will receive a error  
The best way to solve this problem is write a Login Plugin and implement postProcess method  
When Login Plugin receive session invalid message,call Login UI pop and lead user to login.  
After Login success,Login Plugin make Http Request replay  
All this flow is transparent to Api invoker,and invoker not need to think about session invalid problems  



