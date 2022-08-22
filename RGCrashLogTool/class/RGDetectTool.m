//
//  RGDetectTool.m
//  RGCrashLogTool
//
//  Created by yangrui on 2022/8/22.
//  Copyright © 2022 yangrui. All rights reserved.
//

#import "RGDetectTool.h"
#import <UIKit/UIKit.h>
#import "RGCrashLogTool.h"

@implementation RGDetectTool
+ (void)load{
    [RGCrashLogTool startMonitor];
     
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        NSString *log = [RGCrashLogTool crashLog];
        
        if (log.length) {
            NSLog(@"检测到crash 信息");
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height - 200;
            CGRect frame = CGRectMake(10, 100, width, height);
            UITextView *textView = [[UITextView alloc] initWithFrame:frame];
            textView.backgroundColor = [UIColor orangeColor];
            textView.text = log;
            [[UIApplication sharedApplication].keyWindow addSubview:textView];
            [RGCrashLogTool clearCrashLog];
        }
        else{
            NSLog(@"云心正常");
        }
        
    });
}



@end
