//
//  RGDisplayCrashView.h
//  RGCrashLogTool
//
//  Created by yangrui on 2022/8/22.
//  Copyright © 2022 yangrui. All rights reserved.
//

#import <UIKit/UIKit.h>
 

 
@interface RGDisplayCrashView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic, strong) NSString *crashInfo;

+(void)showCrashInfo:(NSString *)crashInfo inView:(UIView *)inView;
@end
