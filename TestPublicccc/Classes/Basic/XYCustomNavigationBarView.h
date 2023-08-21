// 
/*
 FileName: XYCustomNavigationBarView.h
  Program: 
   Author: zhangguang
    Group: XXYY
     Time: 2020/12/20
    Notes: 自定义导航栏view
 */

#import <UIKit/UIKit.h>
#import <XYExtention/XYExtention.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XYNavBarStyle) {
    XYNavBarStyleNormal,    // 居中
    XYNavBarStyleLeft,      // 居左
    XYNavBarStyleRight,       // 居右
};

@interface XYCustomNavigationBarView : UIView

@property(nonatomic, assign)XYNavBarStyle style;   // 默认是普通的样式

@property(nonatomic, strong)UIButton *leftButton;
@property(nonatomic, strong)UIButton *rightButton;
@property(nonatomic, strong)UIView   *shadowLine;
@property(nonatomic, strong)UIView   *bottomLine;  // 默认不展示
@property(nonatomic, strong)NSString * titleString;
@property(nonatomic, strong)UIColor * titleColor;
@property(nonatomic, strong)UIFont * titleFont;

@property(nonatomic, assign)CGFloat leftSpace;  // 左侧间距 默认16
@property(nonatomic, assign)CGFloat rightSpace;  // 右侧间距 默认16

@end

NS_ASSUME_NONNULL_END
