// 
/*
 FileName: XYBasicViewController.m
  Program: 
   Author: zhangguang
    Group: XXYY
     Time: 2020/12/21
    Notes: (文件说明)
 */

#import "XYBasicViewController.h"
#import "XYAppControllers.h"
@interface XYBasicViewController ()

@end

@implementation XYBasicViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 加入栈
    [XYAppControllers addController:self];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self customView];
    [self.view addSubview:self.customNavBarView];
}

-(void)dealloc{
    [XYAppControllers removeController:self];
}

-(void)customView{
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    if (@available(iOS 13.0, *)) {
        return [self isStatusBarDark] ? UIStatusBarStyleDarkContent : UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

-(BOOL)isStatusBarDark{
    return YES;
}

-(void)closeViewController{
    [self closeViewController:YES];
}

- (void)closeViewController:(BOOL)animated {
    // 如果是非basic控制器，自己来控制。category里封装后面在考虑吧
    [XYAppControllers removeController:self];
    if (self.navigationController && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:animated];
    } else {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

#pragma mark lazyload
-(XYCustomNavigationBarView *)customNavBarView{
    CGFloat statusHeight = 20;
    if ([UIDevice isIPhoneNotchScreen]) {
        statusHeight = 44;
    }
    
    if (_customNavBarView == nil) {
        _customNavBarView = [[XYCustomNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, statusHeight + 44)];
        _customNavBarView.titleString = @"";
        [_customNavBarView.leftButton addTarget:self action:@selector(closeViewController) forControlEvents:UIControlEventTouchUpInside];
        _customNavBarView.backgroundColor = [UIColor whiteColor];
    }
    return _customNavBarView;
}



@end
