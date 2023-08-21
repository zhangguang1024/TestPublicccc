//
//  XYActionSheetNavigationController.h
//

#import "XYBasicViewController.h"
#import "XYNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

/// 被XYActionSheetNavigationController弹出的控制器的基类
/// 主要配置了一些常用配置，比如隐藏导航栏，是否允许点击背景自动消失等等
@interface XYActionSheetRootViewController: XYBasicViewController

/// 点击背景时是否自动dismiss，默认YES
@property (nonatomic , assign) BOOL automaticallyDismissWhenTouchBackground;

@end


#pragma mark - XYActionSheetNavigationController

/// 导航栏控制器，主要控制弹出动画，
/// 适用于弹出某个view或者某个vc，将view/vc 从底部弹出，半透明
@interface XYActionSheetNavigationController : XYNavigationController<UIViewControllerTransitioningDelegate>

+ (instancetype)showWithRootViewController:(UIViewController *)rootViewController presentingViewController:(UIViewController *)presentingViewContrller completion:(void (^ __nullable)(void))completion;

+ (instancetype)showWithRootView:(UIView *)rootView presentingViewController:(UIViewController *)presentingViewContrller completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
