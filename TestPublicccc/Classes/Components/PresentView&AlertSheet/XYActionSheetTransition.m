/*
 #####################################################################
 # File    : XYActionSheetTransition.m
 # Notes   : 半透明的控制器的转场动画，类似于actionsheet 底部弹出效果
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

#import "XYActionSheetTransition.h"

@interface XYActionSheetTransition ()

@property (nonatomic, strong) UIView *animationView;

@end

@implementation XYActionSheetTransition

- (instancetype)initWithPresent:(BOOL)isPresent animationView:(UIView *)animationView
{
    self = [super init];
    if(self){
        self.isPresent = isPresent;
        self.animationView = animationView ?: [[UIView alloc] init];
        self.timeInterval = 0.35f;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.50];
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.timeInterval;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    if (self.isPresent)
    {
        UIViewController *toViewVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *toView = toViewVC.view;
        [containerView addSubview:toView];
        
        CGRect oldFrame = self.animationView.frame;
        CGRect frame = oldFrame;
        frame.origin.y = toView.frame.size.height;
        self.animationView.frame = frame;
        toView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.backgroundColor = self.backgroundColor;
            self.animationView.frame = oldFrame;
            
        } completion:^(BOOL finished) {
            BOOL success = ![transitionContext transitionWasCancelled];
            
            if (!success) {
                [toView removeFromSuperview];
            }
            [transitionContext completeTransition:success];
            
        }];
    }else
    {
        UIViewController *fromViewVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIView *fromView = fromViewVC.view;
        
        CGRect oldFrame = self.animationView.frame;
        CGRect frame = oldFrame;
        frame.origin.y = fromView.frame.size.height;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            self.animationView.frame = frame;
            fromView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        } completion:^(BOOL finished) {
            BOOL success = ![transitionContext transitionWasCancelled];
            if (!success) {
                [fromView removeFromSuperview];
            }
            [transitionContext completeTransition:success];
        }];
    }
}

@end
