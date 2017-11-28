//
//  BaseViewController.h
//  RouterDemo
//
//  Created by wyx on 2017/11/22.
//  Copyright © 2017年 ShanghaiJizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic, strong)NSDictionary *parameters;
@property(nonatomic, copy) RouterCallBack callback;

@end
