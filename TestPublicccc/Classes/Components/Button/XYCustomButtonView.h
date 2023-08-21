//
//  XYCustomButtonView.h
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/25.
//  自定义按钮

#import <UIKit/UIKit.h>
#import <XYExtention/XYExtention.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XYButtonPositionType){
    XYButtonPositionTypeDefault = 0,            // 无图片
    XYButtonPositionTypeTypeLeft,           // 图片在左
    XYButtonPositionTypeTypeRight,          // 图片在右
    XYButtonPositionTypeTypeTop,            // 图片在上
    XYButtonPositionTypeTypeBottom,         // 图片在下
    XYButtonPositionTypeLeftAndRight,   // 两个图片，只支持左右
};

@interface XYCustomButtonView : UIView

@property(nonatomic, assign)XYButtonPositionType buttonType;  // 默认Default

// 最小高度，当前布局计算高度小于minHeight时自动居中，insets不生效；高于时自动布局
@property(nonatomic, assign)CGFloat minHeight;
// 内边据 默认(8, 16, 8, 16)
@property(nonatomic, assign)UIEdgeInsets buttonInsets;
// 图文间距  默认：4
@property(nonatomic, assign)CGFloat imageTextSpace;

// 外界只需要设置color，font，title 或attributeString
@property(nonatomic, strong, readonly)UILabel *titleLabel;
// 外界只需要设置 image，width，height
@property(nonatomic, strong, readonly)UIImageView *imageView;
// 外界只需要设置 image，width，height(subImageView 显示与否只跟buttonType有关)
@property(nonatomic, strong, readonly)UIImageView *subImageView;


-(instancetype)initWithWidth:(CGFloat)buttonWidth;

// 上述配置设置好了之后调用  更新子view
-(void)updateSubViews;

// 添加事件
- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state;


@end

NS_ASSUME_NONNULL_END
