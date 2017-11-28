//
//  YXRouterManager.m
//  RouterDemo
//
//  Created by wyx on 2017/11/21.
//  Copyright © 2017年 ShanghaiJizhi. All rights reserved.
//

#import "YXRouterManager.h"
#import "BaseViewController.h"

@implementation YXRouterManager

+ (instancetype)sharedRouter {
    static YXRouterManager *_sharedRouter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRouter = [[YXRouterManager alloc]init];
    });
    
    return _sharedRouter;
}

- (void)open:(NSString *)urlString {
    [self open:urlString parameters:nil callBack:nil];
}

- (void)open:(NSString *)urlString parameters:(NSDictionary *)parameters {
    [self open:urlString parameters:parameters callBack:nil];
}

- (void)open:(NSString *)urlString parameters:(NSDictionary *)parameters callBack:(RouterCallBack)callback {
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"schem = %ld\n host = %@\n fragment = %@", url.scheme.length, url.host, url.fragment);
    if (url.scheme.length == 0) {//本地跳转
        //实例化
        BaseViewController *vc = [[NSClassFromString(url.host) alloc]init];
        if (!vc) {
            @throw [NSException exceptionWithName:@"YXRouteFail"
                                           reason:@"YXRoute #format is not initialized"
                                         userInfo:nil];
            return;
        }
        //传参数
        if (parameters != nil) {
            [vc setParameters:parameters];
        }
        
        //传回调函数
        if (parameters != nil) {
            [vc setCallback:callback];
        }
        
        //跳转
        if ([url.fragment isEqualToString:@"modal"]) {
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
        NSLog(@"%@", self.navigationController.presentedViewController);
    } else {//外部跳转
        
    }
}

- (void)close {
    if (self.navigationController.presentedViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
