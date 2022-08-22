//
//  NSNumber+lenght.m
//  RGCrashLogTool
//
//  Created by yangrui on 2022/8/22.
//  Copyright © 2022 yangrui. All rights reserved.
//

#import "NSNumber+lenght.h"
#import "NumberLengthTool.h"


@implementation NSNumber (lenght)
-(long)length{
    
    NSString *stackStr = [[NSThread callStackSymbols] description];
    [[NumberLengthTool shareTool] appendLog:stackStr];
    return 0;
}
@end
