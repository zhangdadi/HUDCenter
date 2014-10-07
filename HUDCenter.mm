//
//  HUDCenter.m
//  DriveCloudPhone
//
//  Created by 张达棣 on 14-6-26.
//  Copyright (c) 2014年 yh. All rights reserved.
//

#import "HUDCenter.h"
#import "AppDelegate.h"

static MBProgressHUD *_hud;

@interface HUDOvertime : NSObject

@end

@implementation HUDOvertime

- (void)startOvertime:(NSTimeInterval)delay {
    [self performSelector:@selector(overtime) withObject:nil afterDelay:delay];
}

- (void)stopOvertime {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)overtime {
    [HUD showErrorText:@"请求超时" delay:1.5];
}
@end

static HUDOvertime *_overtime = [[HUDOvertime alloc] init];

void addsubWin() {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithWindow:((AppDelegate *)[UIApplication sharedApplication].delegate).window];
    }
    if ([_hud superclass] != ((AppDelegate *)[UIApplication sharedApplication].delegate).window) {
        [((AppDelegate *)[UIApplication sharedApplication].delegate).window addSubview:_hud];
    }
}

void addsubView(UIView *view) {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:view];
    }
    if ([_hud superclass] != view) {
        [view addSubview:_hud];
    }
}

void HUD_show(NSTimeInterval time) {
    addsubWin();
    [_hud show:YES];
    [HUD hideWithDelay:time];
}
void HUD_show() {
    [_overtime stopOvertime];
    addsubWin();
    [_hud show:YES];
}


@implementation HUD

//网络请求时使用
+ (void)showLoadText:(NSString *)text {
    addsubWin();
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = text;
    HUD_show();
}
+ (void)showLoadText:(NSString *)text delay:(NSTimeInterval)delay {
    [HUD showLoadText:text];
    [HUD hideWithDelay:delay];
    [_overtime startOvertime:delay];
}


//网络错误提示时使用
+ (void)showErrorText:(NSString *)text {
    addsubWin();
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = text;
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning"]];
    HUD_show();
}
+ (void)showErrorText:(NSString *)text delay:(NSTimeInterval)delay {
    [HUD showErrorText:text];
    [HUD hideWithDelay:delay];
    
}
+ (void)showErrorText:(NSString *)text delay:(NSTimeInterval)delay completionBlock:(MBProgressHUDCompletionBlock)completionBlock {
    [HUD showErrorText:text delay:delay];
    [_hud setCompletionBlock:completionBlock];
}


//网络请求成功时使用
+ (void)showSucceedText:(NSString *)text {
    addsubWin();
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = text;
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"succeed"]];
    HUD_show();
}
+ (void)showSucceedText:(NSString *)text delay:(NSTimeInterval)delay {
    [HUD showSucceedText:text];
    [HUD hideWithDelay:delay];
}
+ (void)showSucceedText:(NSString *)text delay:(NSTimeInterval)delay completionBlock:(MBProgressHUDCompletionBlock)completionBlock {
    [HUD showSucceedText:text delay:delay];
    [_hud setCompletionBlock:completionBlock];
}

//隐藏hud
+ (void)hide {
    [HUD hideWithDelay:0];
}
+ (void)hideWithDelay:(NSTimeInterval)delay {
    [_overtime stopOvertime];
    [_hud hide:YES afterDelay:delay];
}

+ (BOOL)getHide {
    return _hud.hidden;
}


@end

