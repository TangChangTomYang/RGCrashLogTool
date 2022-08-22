//
//  NumberLengthTool.m
//  RGCrashLogTool
//
//  Created by yangrui on 2022/8/22.
//  Copyright © 2022 yangrui. All rights reserved.
//

#import "NumberLengthTool.h"
#import <UIKit/UIKit.h>

@implementation NumberLengthTool

static NumberLengthTool *__tool = nil;
+(instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __tool = [[self alloc] init];
    });
    return __tool;
}

// 沙盒地址
NSString *logPath(){

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *appName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    NSString *fileName = [NSString stringWithFormat:@"%@_NSNumberLenLog.txt", appName];
    path = [path stringByAppendingPathComponent:fileName];
    NSLog(@"path : %@", path);
    return path;

}

-(NSOutputStream *)outputStream{
    if (!_outputStream) {
        _outputStream = [NSOutputStream outputStreamToFileAtPath:logPath() append:YES];
        [_outputStream open];
    }
    return _outputStream;
}

-(NSString *)fetchDeviceInfo{
    UIDevice *device = [UIDevice currentDevice] ;
    NSString *devInfo = [NSString stringWithFormat:@"\ndeviceName: %@\nmodel: %@\nsystemName: %@\nsystemVersion: %@\n",device.name,device.model ,device.systemName,device.systemVersion];
    return devInfo;
}

-(NSString *)fetchAppInfo{
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];

    NSString *appName = dic[@"CFBundleName"];
    NSString *projectName = dic[@"CFBundleExecutable"];
    NSString *version = dic[@"CFBundleShortVersionString"];
    NSString *build = dic[@"CFBundleVersion"];
    return  [NSString stringWithFormat:@"\nappName: %@\nprojectName: %@\nversion: %@\nbuild:%@\n",appName,projectName,version ,build];
}


-(void)appendLog:(NSString *)stackStr{
    NSString *dateStr = [NSDate date].description;
    NSString *start = [NSString stringWithFormat:@"\n*****start*****%@*************\n", dateStr];
    NSString *end = [NSString stringWithFormat:@"\n*****end***********%@**********\n\n", dateStr];

    // 崩溃的原因, 可以有崩溃的原因(数组越界/ 字典nil/ 调用未知方法) 等等
    NSString *devInfo = [self fetchDeviceInfo];
    NSString *appInfo = [self fetchAppInfo];
   
    NSString *callStackMsg =  [NSString stringWithFormat:@"堆栈调用信息: \n%@\n",stackStr];

    NSString *logMsg = [NSString stringWithFormat:@"%@%@%@\n%@\n%@\n",
                        start,
                        devInfo,
                        appInfo,
                        callStackMsg,
                        end];
    NSData *logMsgData = [logMsg dataUsingEncoding:NSUTF8StringEncoding];
    [self.outputStream write:logMsgData.bytes maxLength:logMsgData.length];

}
@end
