//
//  HUDCenter.h
//  DriveCloudPhone
//
//  Created by 张达棣 on 14-6-26.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface HUD : NSObject
//网络请求时使用
+ (void)showLoadText:(NSString *)text;
+ (void)showLoadText:(NSString *)text delay:(NSTimeInterval)delay;

//网络错误提示时使用
+ (void)showErrorText:(NSString *)text;
+ (void)showErrorText:(NSString *)text delay:(NSTimeInterval)delay;
+ (void)showErrorText:(NSString *)text delay:(NSTimeInterval)delay completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

//网络请求成功时使用
+ (void)showSucceedText:(NSString *)text;
+ (void)showSucceedText:(NSString *)text delay:(NSTimeInterval)delay;
+ (void)showSucceedText:(NSString *)text delay:(NSTimeInterval)delay completionBlock:(MBProgressHUDCompletionBlock)completionBlock;

//隐藏hud
+ (void)hide;
+ (void)hideWithDelay:(NSTimeInterval)delay;
+ (BOOL)getHide;

@end
