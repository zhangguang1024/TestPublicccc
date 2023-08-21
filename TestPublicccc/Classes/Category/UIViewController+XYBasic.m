//
//  UIViewController+XYBasic.m
//  XYBasicClass
//
//  Created by ZJS on 2022/6/23.
//

#import "UIViewController+XYBasic.h"
#import "XYAppControllers.h"
@implementation UIViewController (XYBasic)

/**
 * 从下往上弹出指定类名的视图控制器
 * 返回控制器实例 (autorelease)。
 * 父控制器默认 [AppControllers mostRecentController]；
 * 如果 [AppControllers mostRecentController] 返回 nil，则使用 [AppUtil getWindow].rootViewController；
 * 如果 [AppUtil getWindow].rootViewController 返回 nil，则不会打开视图控制器
 */
+(id)presentViewController:(BOOL)animated {
    UIViewController *parentController = [XYAppControllers mostRecentController];

    if (nil == parentController) {
        parentController = [self getCurrentWindow].rootViewController;
        if (nil == parentController) {
            return nil;
        }
    }

    UIViewController *ctrl = [[self alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [parentController presentViewController:nav animated:animated completion:^{}];
#pragma clang diagnostic pop
    
    return ctrl;
}

+(UIWindow *)getCurrentWindow {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (![window isKindOfClass:[UIWindow class]]) {
            continue;
        }

        if (window.windowLevel == UIWindowLevelNormal) {
            return window;
        }
    }

    return [[UIApplication sharedApplication] keyWindow];
}


@end
