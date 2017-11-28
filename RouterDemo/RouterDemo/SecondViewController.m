//
//  SecondViewController.m
//  RouterDemo
//
//  Created by wyx on 2017/11/21.
//  Copyright © 2017年 ShanghaiJizhi. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 44);
    [button setTitle:self.string forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 100, 44);
    [btn setTitle:@"next" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.text = self.dictionary[@"person"];
    
    button.titleLabel.text = self.dictionary[@"person"];
    NSLog(@"传值 = %@", self.person.name);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self write:@"string1"];
        sleep(5);
        [self write:@"string2"];
        [self write:@"string3"];
    });
}

- (void)write:(NSString*)str {
    dispatch_queue_t queue1 = dispatch_queue_create("test1",DISPATCH_QUEUE_SERIAL);
//    NSLog(@"线程标签%s", dispatch_queue_get_label(queue1));
    dispatch_async(queue1, ^{
        NSLog(@"%@", str);
    });
}

- (void)buttonClick {
//    [[YXRouterManager sharedRouter]open:@"//ViewController"];
    self.callback(@{@"testBlock" : @"dada"});
}

- (void)btnClick {
    [[YXRouterManager sharedRouter]close];
    [[YXRouterManager sharedRouter]open:@"//ThirdViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
