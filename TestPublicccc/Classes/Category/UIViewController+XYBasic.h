//
//  UIViewController+XYBasic.h
//  XYBasicClass
//
//  Created by ZJS on 2022/6/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XYBasic)

/**
 * 从下往上弹出指定类名的视图控制器
 * 返回控制器实例 (autorelease)。
 * 父控制器默认 [AppControllers mostRecentController]；
 * 如果 [AppControllers mostRecentController] 返回 nil，则使用 [AppUtil getWindow].rootViewController；
 * 如果 [AppUtil getWindow].rootViewController 返回 nil，则不会打开视图控制器
 */
+(id)presentViewController:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
