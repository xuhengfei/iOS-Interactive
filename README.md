目前的App应用越来越复杂，客户端与服务器的数据交互也越来越多  
随着业务的发展，这些代码越来越混乱与复杂化  
Interactive框架具有如下优势：  
1.极大的简化HTTP交互的使用方式  
2.能够维护大量的API类型，并且可重用  
3.支持API返回结果的Mock，使用简单（文档中暂时未提到）  
4.支持API请求的前置后置处理，具备插件机制  （文档中暂时未提到）  

gitlab 地址：[http://gitlab.alibaba-inc.com/zhoufang/ios-interactive](http://gitlab.alibaba-inc.com/zhoufang/ios-interactive)  

目录  
#####[Interactive框架设计思路](#api)
#####[Interactive框架应用举例](#example)
#####[MTOP Api应用举例](#mtop-example)
#####[MTOP Api开发规范](#mtop-spec)

***
#####<span>Interactive框架设计思路</span>  
首先做一个名称解释：  
Api: InteractiveApi 的简写，客户端与服务器进行的一次请求与响应，即成为一个API  
      比如一个带有账号密码的http请求，和返回的成功或者失败，即是一个API  
      比如一个带有商品id 的商品信息查询请求与响应，即是一个API  

App客户端与服务器的交互，一般都是通过HTTP请求来实现，整个流程如下所示：  
* 构建一个Http请求  
* 将请求发送出去  
* 接收请求的响应  
* 将响应的内容进行解析  

对于上面的流程，我们对其进行一个总结，可以归纳成两种类型  
<table border="1"><tr><td>不变的</td><td>变化的</td><td>解释</td></tr><tr><td></td><td>构建一个Http请求</td><td>每一个不同的API的Http请求内容都不一样</td></tr><tr><td>将请求发送出去</td><td></td><td>固定的一个HTTP规范动作</td></tr><tr><td>接收请求的响应</td><td></td><td>固定的一个HTTP规范动作</td></tr><tr><td></td><td>将响应的内容进行解析</td><td>每一个不同的API的返回数据格式都不一样</td></tr></table>
对于上述的结论，我们进行抽象，可以抽象为如下3个协议：  
```objective-c
//Api协议
@protocol XHFInteractiveApi <NSObject>

@required
//获取HTTP请求
-(ASIHTTPRequest *) getHttpRequest;
//获取这个HTTP请求返回结果的解析器
-(id<XHFResponseParser>) getResponseParser;

@end
//解析器协议
@protocol XHFResponseParser <NSObject>
@required
-(id)parse:(ASIHTTPRequest *)request;

@end
```
```objective-c
//执行器协议
@protocol XHFInteractiveExecutor <NSObject>

@required
//执行一个Api，同步的方式返回一个解析后的对象
-(id)execute:(id<XHFInteractiveApi>)api;

@end

```

XHFInteractiveApi协议表明这是一个交互的API  
XHFResponseParser协议表明是一个解析器，用于对返回结果的解析  
XHFInteractiveExecutor协议表明这是一个执行器，可以将一个API进行执行操作
其中XHFInteractiveApi和XHFResponseParser组合成一个API,对应上述表格中变化部分  
XHFInteractiveExecutor协议对应上述表格中不变部分  


OK,Interactive框架的核心就是这3个协议。  
利用这3个协议，我们的一个交互请求代码将会非常简洁优美，伪代码如下：  
```objective-c
XHFInteractiveApi *api=[[SomeApi alloc]init];
XHFInteractiveExecutor *executor=[[SomeExecutor alloc]init];
ReturnResult *result=[executor execute:api];
//获取到result后进行业务处理
```
因为这3个协议是对Http请求方式的高度抽象，因此几乎所有给予http请求的交互，都可以在此基础上进行扩展。  

***
#####<span>Interactive框架应用举例</span>
有了上面的框架，我们便可以通过此框架来实际应用了  
框架会自带一些常用的InteractiveExecutor，比如  
SimpleInteractiveExecutor:简单执行器，将Http请求直接进行发送与接收，没有任何加工  
CacheableInteractiveExecutor:可缓存的执行器，可以对一些请求进行缓存，提高性能  
RetryInteractiveExecutor:重试执行器，如果请求失败，可以自动进行重试  
还可以用很多执行器，只要实现了XHFInteractiveExecutor协议即可。  
有需要的自行进行扩展即可  
下面给出SimpleInteractiveExecutor代码，后续的举例中将会用到  
```objective-c
#import "SimpleInteractiveExecutor.h"
#import "ASIHTTPRequest.h"

@implementation SimpleInteractiveExecutor


- (id)execute:(id<XHFInteractiveApi>)api{
    ASIHTTPRequest *req=[api getHttpRequest];
    [req startSynchronous];
    return [[api getResponseParser] parse:req];
}
@end
```

实际工作中如何来使用Interactive框架，下面举几个例子  
**一个登陆动作的实现**   
登陆是一个非常常见的App操作，一般是在请求中带上name和password，进行一个登陆行为。  
服务器端则返回登陆成功或者失败  
一个登陆的交互，我们称它为一个Api，这里取名为LoginApi  
一个Api应该包括3部分：  
  * InteractiveApi   一个实现了XHFInteractiveApi协议的对象  
  * ResponseParser  一个实现了XHFResponseParser协议的解析器  
  * ResponseItem  通过解析器解析出来的对象  
我们建议将这3个类写在一个文件中，并且对命名规则进行规范。可以极大的规范化代码，减少大量的沟通成本  
下面是LoginApi的头文件内容：  
```objective-c
//LoginApi.h

//定义一个LoginApi，实现XHFInteractiveApi
@interface LoginApi : NSObject<XHFInteractiveApi>
//构造方法，传入用户名和密码
-(id)initWithName:(NSString *)name password:(NSString*)password;

@end

//定义一个解析器，用于对返回结果进行解析
@interface LoginParser : NSObject<XHFResponseParser>

@end

//这里没有定义ResponseItem 类
//因为我们简化了解析的结果为YES or NO ，无需定义一个新的类
//如果是业务代码，建议在这里定义解析的返回结构类
```
针对上面的头文件，下面是实现文件：
```objective-c
//LoginApi.m

//LoginApi的实现代码
@implementation LoginApi{
    NSString *_name;
    NSString *_password;
}

- (id)initWithName:(NSString *)name password:(NSString *)password{
    self=[super init];
    if(self){
        _name=name;
        _password=password;
    }
    return self;
}

- (ASIHTTPRequest *)getHttpRequest{
    NSString *url=[NSString stringWithFormat:@"http://xxx.com/login.do?name=%@&password=%@",_name,_password];
    ASIHTTPRequest *req=[[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:url]]autorelease];
    [url release];
    return req;
}

- (id<XHFResponseParser>)getResponseParser{
    return [[[LoginParser alloc]init]autorelease];
}

@end

//LoginParser的实现代码
@implementation LoginParser

- (id)parse:(ASIHTTPRequest *)request{
    NSString *result=request.responseString;
    if([result isEqualToString:@"true"]){
        return YES;
    }
    return NO;
}

@end
```

以上定义了一个LoginApi，下面如何来实现这个登陆请求：  
```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    SimpleInteractiveExecutor *executor=[[[SimpleInteractiveExecutor alloc]init]autorelease];
    
    LoginApi *api=[[[LoginApi alloc]initWithName:@"admin" password:@"123456"]autorelease];
    NSNumber *num=[executor execute:api];
    BOOL success=[num boolValue];
    NSLog(@"login %@",success?@"Success":@"Fail");
}
```

总结一下，使用Interactive框架，数据交互将会非常简单  
1.创建一个Api对象  
2.执行这个Api对象  
3.拿到返回结果进行业务处理  

***
#####<span>MTOP应用举例</span>
在淘宝实际业务中，我们普遍采用MTOP进行交互，因此我们通过InteractiveApi进行扩展，将会提供MTOPInteractiveApi，方便使用MTOP进行交互。  

如果有一个新的MTOP接口需要开发，比如ItemQueryApi,可以将此类继承MTOPInteractiveApi  
声明一个构造函数 
```objective-c
-(id)initWithItemId:(NSNumber *)itemId;
```
覆写getResponseParser方法

***
##### <span>MTOP Api开发规范</span>
如何在淘宝业务中使用MTOPInteractiveApi，下面进行简单说明  
使用MTOPInteractive开发业务，我们分成3种角色：  
framwork provider： 框架开发者，就是我  
api provider： 每一个mtop的接口，对应一个InteractiveApi，开发这个api的人即是api provider  
api invoker:   Api调用者，一个InteractiveApi开发完成后，所用的用户都可以使用它  

这里重点要说的是api provider，我们在开发api是，尽可能保证独立性。一个api开发出来后应该可以被公用，所有需要使用这个mtop接口的人只有将你写的api拿过来用即可。

为了让api invoker使用起来尽可能简单，我们需要对api provider要求尽可能严格，保证产出api的质量。  
下面说一下作为api provider，我们应该努力做到的几点原则：  
1.文件规范  
一个Api会涉及3个类(InteractiveApi,ResponseParser,ResponseItem)，务必将这3个类写在一个文件中(.h  .m 文件)  
所有的Api都应放在一个目录下，方便api invoker查找  
2.一个Api通过构造函数创建后，即可使用。无需其他的配置。  
比如登陆Api：  LoginApi *api=[[LoginApi alloc]initWithName:@"admin" password:@"123456"];  
此一句后，即可使用 [executor execute:api]
