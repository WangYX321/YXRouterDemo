//
//  BaseViewController.m
//  RouterDemo
//
//  Created by wyx on 2017/11/22.
//  Copyright © 2017年 ShanghaiJizhi. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>
@interface BaseViewController ()

@property (nonatomic, strong) UIView *yxNavigationBar;
@property (nonatomic, strong) UIButton *leftBarButton;
@property (nonatomic, strong) UIButton *rightBarButton;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.yxNavigationBar];
    
    if (self.navigationController.viewControllers.count > 1 || !self.navigationController) {
        self.leftBarButton.hidden = NO;
    } else {
        self.leftBarButton.hidden = YES;
    }
    
}

#pragma mark - Lazy
- (UIView *)yxNavigationBar {
    if (_yxNavigationBar == nil) {
        _yxNavigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        _yxNavigationBar.backgroundColor = [UIColor lightGrayColor];
        _yxNavigationBar.tintColor = [UIColor whiteColor];
    }
    return _yxNavigationBar;
}

- (UIButton *)leftBarButton {
    if (_leftBarButton == nil) {
        _leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBarButton.frame = CGRectMake(20, 20, 44, 44);
        [_leftBarButton setTitle:@"返回" forState:UIControlStateNormal];
        [_leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBarButton addTarget:self action:@selector(leftBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.yxNavigationBar addSubview:_leftBarButton];
    }
    return _leftBarButton;
}

- (void)leftBarButtonAction:(UIBarButtonItem *)sender {
    [[YXRouterManager sharedRouter]close];
}

#pragma mark - Setter Method
- (void)setParameters:(NSDictionary *)parameters {
    NSArray *props = [self getAllProperties];
    NSLog(@"所有属性 = %@",props);
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([props containsObject:key]) {
            SEL setSel = [self creatSetterWithPropertyName:key];
            [self performSelectorOnMainThread:setSel withObject:obj waitUntilDone:[NSThread isMainThread]];
        }
    }];
    _parameters = parameters;
}

//获取所有属性的字符串形式
- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

#pragma mark -- 通过字符串来创建该字符串的Setter方法，并返回
- (SEL) creatSetterWithPropertyName: (NSString *) propertyName{
    //1.首字母大写
    propertyName = propertyName.capitalizedString;
    //2.拼接上set关键字
    propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
    //3.返回set方法
    return NSSelectorFromString(propertyName);
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
