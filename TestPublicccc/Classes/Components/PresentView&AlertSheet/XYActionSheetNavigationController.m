//
//  XYActionSheetNavigationController.m
//
#import "XYActionSheetNavigationController.h"
#import "XYActionSheetTransition.h"

@implementation XYActionSheetRootViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.automaticallyDismissWhenTouchBackground = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
}

- (BOOL)prefersNavigationBarHidden {
    return YES;
}

- (IBAction)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.automaticallyDismissWhenTouchBackground) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    if (self.view == touch.view) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

@interface XYActionSheetNavigationController ()

@property (nonatomic, weak) UIViewController *rootViewController;

@end

@implementation XYActionSheetNavigationController

+ (instancetype)showWithRootViewController:(UIViewController *)rootViewController presentingViewController:(UIViewController *)presentingViewContrller completion:(void (^ __nullable)(void))completion {
    XYActionSheetNavigationController *nav = [[XYActionSheetNavigationController alloc]initWithRootViewController:rootViewController];
    [presentingViewContrller presentViewController:nav animated:YES completion:completion];
    return nav;
}

+ (instancetype)showWithRootView:(UIView *)rootView presentingViewController:(UIViewController *)presentingViewContrller completion:(void (^ __nullable)(void))completion {
    XYActionSheetRootViewController *rootVC = [[XYActionSheetRootViewController alloc] init];
    [rootVC.view addSubview:rootView];
    rootVC.customNavBarView.hidden = YES;
    rootView.top = rootVC.view.height - rootView.height;
    return [self showWithRootViewController:rootVC presentingViewController:presentingViewContrller completion:completion];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.rootViewController = rootViewController;
        self.transitioningDelegate = self;
        self.modalPresentationCapturesStatusBarAppearance = YES;
    }
    return self;
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

// 直接dismiss是不行滴
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.rootViewController dismissViewControllerAnimated:flag completion:completion];
}

#pragma mark -- UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    XYActionSheetTransition *transition = [[XYActionSheetTransition alloc] initWithPresent:YES animationView:self.rootViewController.view];
    transition.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.55f];
    return transition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[XYActionSheetTransition alloc] initWithPresent:NO animationView:self.rootViewController.view];
}

@end
