//
//  NumberLengthTool.h
//  RGCrashLogTool
//
//  Created by yangrui on 2022/8/22.
//  Copyright © 2022 yangrui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NumberLengthTool : NSObject
@property(nonatomic, strong)NSOutputStream *outputStream;
+(instancetype)shareTool;
-(void)appendLog:(NSString *)stackStr;
@end

NS_ASSUME_NONNULL_END
