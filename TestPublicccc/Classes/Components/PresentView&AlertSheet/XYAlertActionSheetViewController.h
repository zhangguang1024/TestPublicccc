//
//  XYAlertActionSheetViewController.h
//  仿系统 UIAlertViewControler中的sheet样式
//

#import <UIKit/UIKit.h>

#import "XYActionSheetNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AlertActionItem)

/// 警告单元格数据配置
+ (NSDictionary *)warningItemWithTitle:(nullable NSString *)title;

@end

#pragma mark - XYAlertSheetAction

@interface XYAlertSheetAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle handler:(void (^ __nullable)(XYAlertSheetAction *action))handler;

/// 初始化
/// @param item 每个action里面的数据
///        节点名：title,titleColor,subTitle,subTitleColor
///        若未配置，则使用默认
/// @param handler 点击回调
+ (instancetype)actionWithItem:(NSDictionary *)item handler:(void (^ __nullable)(XYAlertSheetAction *action))handler;

@property (nonatomic) NSInteger tag;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *subTitleColor;

@end

#pragma mark - XYAlertActionSheetCell

@interface XYAlertActionSheetCell : UITableViewCell

@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *subTitleColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *subTitleFont UI_APPEARANCE_SELECTOR;

@end

@interface XYAlertActionSheetViewController : XYActionSheetRootViewController

/// 对外公开，设置特殊样式
@property (nonatomic, strong, readonly) UIButton *cancelButton;
@property (nonatomic, strong, readonly) UILabel *titleLabel;

- (void)addAction:(XYAlertSheetAction *)action;
- (void)addActions:(NSArray<XYAlertSheetAction *> *)actions;

#pragma mark - config 配置项，想自定义了就继承，重写即可
-(CGFloat)configCellHeight;
-(UIColor *)configCellColor;
-(UIFont *)configCellFont;
-(UIColor *)configCancelButtonColor;
-(UIFont *)configCancelButtonFont;

@end

NS_ASSUME_NONNULL_END
