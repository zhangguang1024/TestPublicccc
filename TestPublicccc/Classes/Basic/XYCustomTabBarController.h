//
//  XYCustomTabBarController.h
//  XYBasicClass
//
//  Created by XXYY on 2021/3/14.
//

#import <UIKit/UIKit.h>
#import "XYCustomTabbar.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYCustomTabBarController : UITabBarController

@property (strong, nonatomic) XYCustomTabbar *customTabbar;

-(void)customInit;

-(void)customTabbarView;

// 自动补充了navVC 不用再加了
-(void)setViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage;

// 中间按钮点击事件
- (void)centerButtonClick;

@end

NS_ASSUME_NONNULL_END
