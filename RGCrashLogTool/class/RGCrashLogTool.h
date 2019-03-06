//
//  RGCrashLogTool.h
//  NSExceptionDemo
//
//  Created by yangrui on 2019/3/6.
//  Copyright © 2019 yangrui. All rights reserved.
//  崩溃日志监听工具

#import <Foundation/Foundation.h>


typedef void (^CrachCallback)(void) ;
@interface RGCrashLogTool : NSObject

 
/**
 开启监听/ 收集系统的崩溃日志
 */
+(void)startMonitor;

/**
 获取上次崩溃的日志
 */
+(NSString *)crashLog;

/**
 清空以前的日志记录
 */
+(void)clearCrashLog;

@end

