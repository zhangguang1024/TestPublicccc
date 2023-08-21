// 
/*
 FileName: XYBasicViewController.h
  Program: 
   Author: zhangguang
    Group: XXYY
     Time: 2020/12/21
    Notes: 基类控制器(直接自定义导航栏)
 */

#import <UIKit/UIKit.h>
#import "XYCustomNavigationBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYBasicViewController : UIViewController

@property(nonatomic, strong)XYCustomNavigationBarView *customNavBarView;

-(void)customView;

// 左侧关闭按钮方法
-(void)closeViewController;
// 手动调用的关闭方法
- (void)closeViewController:(BOOL)animated;

// 重写设置 状态栏风格 dark 还是 light
-(BOOL)isStatusBarDark;

@end

NS_ASSUME_NONNULL_END
