/*
 #####################################################################
 # File    : XYActionSheetTransition.h
 # Notes   : 半透明的控制器的转场动画，actionsheet式底部弹出效果
 #####################################################################
 ### Change Logs   ###################################################
 #####################################################################
 ---------------------------------------------------------------------
 # Date  :
 # Author:
 # Notes :
 #
 #####################################################################
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYActionSheetTransition : NSObject <UIViewControllerAnimatedTransitioning>

/// 参与动画的视图(目标视图），默认效果底部弹出
@property (nonatomic, strong , readonly) UIView *animationView;

/// 动画时间,默认 0.35s
@property (nonatomic, assign) NSTimeInterval timeInterval;

/// 背景颜色，默认颜色为黑色半透明（[UIColor colorWithWhite:0.0 alpha:0.50]）
@property (nonatomic, strong) UIColor *backgroundColor;

/// present/dismiss
@property (nonatomic, assign) BOOL isPresent;

- (instancetype)initWithPresent:(BOOL)isPresent animationView:(UIView *)animationView;

@end

NS_ASSUME_NONNULL_END
