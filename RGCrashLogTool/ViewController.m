//
//  ViewController.m
//  RGCrashLogTool
//
//  Created by yangrui on 2019/3/6.
//  Copyright © 2019 yangrui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self test1:^{
       id a = @[][10];
        a = nil;;
    }];
}
 
-(void)test1:(void(^)())block{  [self test2:block]; }
-(void)test2:(void(^)())block{  [self test3:block]; }
-(void)test3:(void(^)())block{  [self test4:block]; }
-(void)test4:(void(^)())block{  [self test5:block]; }

-(void)test5:(void(^)())block{ block();}
@end
