//
//  RGDetectTool.m
//  RGCrashLogTool
//
//  Created by yangrui on 2022/8/22.
//  Copyright © 2022 yangrui. All rights reserved.
//

#import "RGDetectCrashManagerTool.h"
#import <UIKit/UIKit.h>
#import "RGCrashLogTool.h"
#import "RGDisplayCrashView.h"






@implementation RGDetectCrashManagerTool
+ (void)load{
    [RGCrashLogTool startMonitor];
     
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        NSString *log = [RGCrashLogTool crashLog];
        
        if (log.length) {
             
            NSLog(@"检测到crash 信息");
            [RGDisplayCrashView showCrashInfo:log
                                       inView:[UIApplication sharedApplication].keyWindow];;
            [RGCrashLogTool clearCrashLog];
        }
        else{
            NSLog(@"运行正常");
        }
        
    });
}



@end
