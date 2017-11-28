//
//  SecondViewController.h
//  RouterDemo
//
//  Created by wyx on 2017/11/21.
//  Copyright © 2017年 ShanghaiJizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Person.h"
@interface SecondViewController : BaseViewController

@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) Person *person;

@end
