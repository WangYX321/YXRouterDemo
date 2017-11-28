//
//  ViewController.m
//  RouterDemo
//
//  Created by wyx on 2017/11/21.
//  Copyright © 2017年 ShanghaiJizhi. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 44);
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClick {
    Person *person = [[Person alloc]init];
    person.name = @"jacky";
    person.age = 26;
    
    [[YXRouterManager sharedRouter]open:@"//SecondViewController#modal" parameters:@{@"string" : @"age", @"array" : @[@"1", @"2"], @"pers" : person} callBack:^(NSDictionary *params) {
        NSLog(@"%@", params);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
