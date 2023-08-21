//
//  XYCustomTabbar.h
//  XYBasicClass
//
//  Created by XXYY on 2021/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYCustomTabbar : UITabBar

@property (nonatomic, assign)NSInteger itemCount; // 总共几个控制器

@property (nonatomic, assign)CGFloat centerButtonSpace; // 中间按钮距离顶部距离默认 -14

@property (nonatomic, assign)BOOL isHiddenTopLine;  // 默认展示

- (instancetype)initWithCenterImage:(NSString *)centerImage selectImage:(NSString *)selectImage target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
