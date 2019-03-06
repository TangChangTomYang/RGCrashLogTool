//
//  RGCrashLogTool.m
//  NSExceptionDemo
//
//  Created by yangrui on 2019/3/6.
//  Copyright © 2019 yangrui. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RGCrashLogTool.h"


@interface RGCrashLogTool()
/**文件输出流*/
@property(nonatomic, strong)NSOutputStream *outputStream;
@end


@implementation RGCrashLogTool

static RGCrashLogTool *_crashLogTool = nil;
+(instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _crashLogTool = [[self alloc] init];
    });
    return _crashLogTool;
}



/**
 开启监听/ 收集系统的崩溃日志
 */
+(void)startMonitor{
    
       [self  setCrashLogHandler];
}

/**
 获取上次崩溃的日志
 */
+(NSString *)crashLog{
    if( !isCrashLogFileExists()) return nil;
    
    NSString *path = fetchCrashLogFilePath();
    return  [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:nil];
}

/**
 清空以前的日志记录
 */
+(void)clearCrashLog{
    if(isCrashLogFileExists()){
        NSString *path = fetchCrashLogFilePath();
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}




// 沙盒地址
NSString *fetchCrashLogFilePath(){
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = @"/Users/yangrui/Desktop/";
    NSString *appName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    NSString *fileName = [NSString stringWithFormat:@"%@.txt", appName];
    return  [path stringByAppendingPathComponent:fileName];
    
}

NSString *fetchDeviceInfo(){
    UIDevice *device = [UIDevice currentDevice] ;
    NSString *devInfo = [NSString stringWithFormat:@"\ndeviceName: %@\nmodel: %@\nsystemName: %@\nsystemVersion: %@\n",device.name,device.model ,device.systemName,device.systemVersion];
    return devInfo;
}

NSString *fetchAppInfo(){
    NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *appName = dic[@"CFBundleName"];
    NSString *projectName = dic[@"CFBundleExecutable"];
    NSString *version = dic[@"CFBundleShortVersionString"];
    NSString *build = dic[@"CFBundleVersion"];
    return  [NSString stringWithFormat:@"\nappName: %@\nprojectName: %@\nversion: %@\nbuild:%@\n",appName,projectName,version ,build];
}

BOOL isCrashLogFileExists(){
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = fetchCrashLogFilePath();
    return  [fileMgr fileExistsAtPath:path]  ;
}


/**
 出现崩溃异常系统会回调这个函数
 */
void crashExceptionHandler(NSException *exception){
    
    NSString *dateStr = [NSDate date].description;
    NSString *start = [NSString stringWithFormat:@"\n\n\n\n\n*******start***********%@********************\n", dateStr];
    NSString *end = [NSString stringWithFormat:@"\n*******end***********%@********************\n", dateStr];
    
    // 崩溃的原因, 可以有崩溃的原因(数组越界/ 字典nil/ 调用未知方法) 等等
    NSString *devInfo = fetchDeviceInfo();
    NSString *appInfo = fetchAppInfo();
    
    NSString *name = [NSString stringWithFormat:@"异常名称: \n%@\n",exception.name];
    NSString *reason = [NSString stringWithFormat:@"异常原因: \n%@\n",exception.reason];
    
    NSArray<NSString *> *callStackSymbolArr = exception.callStackSymbols;
    NSString *callStackMsg =  [NSString stringWithFormat:@"堆栈调用信息: \n%@\n",[callStackSymbolArr componentsJoinedByString:@"\n"]];
    
    NSString *logMsg = [NSString stringWithFormat:@"%@%@%@\n\n%@\n%@\n%@%@",start,devInfo, appInfo,name,reason,callStackMsg,end];
    NSData *logMsgData = [logMsg dataUsingEncoding:NSUTF8StringEncoding];
    
    
    // 将数据写入文件
    [[RGCrashLogTool shareTool].outputStream write:logMsgData.bytes maxLength:logMsgData.length];
    [[RGCrashLogTool shareTool].outputStream close];
    [RGCrashLogTool shareTool].outputStream = nil; 
}

/**
 设置系统异常回调函数
 */
+(void)setCrashLogHandler{
   
    NSSetUncaughtExceptionHandler(&crashExceptionHandler);
}

/**
 获取系统异常回调函数
 */
+(NSUncaughtExceptionHandler *)getCrashLogHandler{
    return  NSGetUncaughtExceptionHandler();
}


-(NSOutputStream *)outputStream{
    if (!_outputStream) {
        _outputStream = [NSOutputStream outputStreamToFileAtPath:fetchCrashLogFilePath() append:YES];
        [_outputStream open];
    }
    return _outputStream;
}

@end
