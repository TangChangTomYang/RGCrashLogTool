//
//  RGDisplayCrashView.m
//  RGCrashLogTool
//
//  Created by yangrui on 2022/8/22.
//  Copyright © 2022 yangrui. All rights reserved.
//

#import "RGDisplayCrashView.h"

@implementation RGDisplayCrashView

- (IBAction)closeBtnClick:(id)sender {
    [self dismiss];
}

- (IBAction)sendBtnClick:(id)sender {
    [self dismiss];
}
 
-(void)dismiss{
    [self removeFromSuperview];
}

-(void)setCrashInfo:(NSString *)crashInfo{
    _crashInfo = crashInfo;
    if (crashInfo.length > 0) {
        self.textView.text = crashInfo;
    }
    else{
        self.textView.text = @"";
    }
}

+(void)showCrashInfo:(NSString *)crashInfo inView:(UIView *)inView{
    CGRect frame = inView.bounds;
    RGDisplayCrashView *view = [RGDisplayCrashView viewWithFrame:frame];
    view.crashInfo = crashInfo;
    [inView addSubview:view];
}

+(instancetype)viewWithFrame:(CGRect)frame{
    NSBundle *bundle = [NSBundle bundleForClass:self];
    NSArray *nibs = [bundle loadNibNamed:@"RGDisplayCrashView" owner:nil options:nil];
    RGDisplayCrashView *view = (RGDisplayCrashView *)[nibs lastObject];
    view.frame = frame;
    return view;
}
@end
