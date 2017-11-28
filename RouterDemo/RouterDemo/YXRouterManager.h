//
//  YXRouterManager.h
//  RouterDemo
//
//  Created by wyx on 2017/11/21.
//  Copyright © 2017年 ShanghaiJizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^RouterCallBack)(NSDictionary *params);

@interface YXRouterManager : NSObject

+ (instancetype)sharedRouter;

@property(nonatomic, strong)UINavigationController *navigationController;
//app://viewcontroller#push

/**
 打开新页面

 @param urlString 地址字符串
 */
- (void)open:(NSString *)urlString;

/**
 打开新页面，带参数

 @param urlString 地址字符串
 @param parameters 传入参数
 */
- (void)open:(NSString*)urlString parameters:(NSDictionary *)parameters;

/**
 打开新页面，带参数，带回调

 @param urlString 地址字符串
 @param parameters 传入参数
 @param callback 回调函数
 */
- (void)open:(NSString*)urlString parameters:(NSDictionary *)parameters callBack:(RouterCallBack)callback;

/**
 关闭当前页面
 分别处理modal跳转和push跳转两种形式
 */
- (void)close;
@end
