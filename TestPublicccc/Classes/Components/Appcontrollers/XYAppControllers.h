//
//  XYAppControllers.h
//  XYExtention
//
//  Created by XXYY on 2021/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYAppControllers : NSObject{
@private
    NSMutableArray *_controllerStack;           // 当前 Controller 堆栈
}

@property (readonly) NSMutableArray *controllerStack;

+ (instancetype)sharedAppControllers;

/**
 * 记录 Controller 到堆栈中
 */
+ (void)addController:(UIViewController *)ctrl;

/**
 * 从堆栈中移除 Controller
 */
+ (void)removeController:(UIViewController *)ctrl;

/**
 * 获取最新激活的 UIViewController
 */
+ (UIViewController *)mostRecentController;

/**
 * 获取 Controller 堆栈信息
 */
+ (NSString *)stackPath;

@end

NS_ASSUME_NONNULL_END
