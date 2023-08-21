//
//  XYTableHeaderFooterView.h
//  XYBasicClass
//
//  Created by 张光 on 2022/3/19.
//

#import <UIKit/UIKit.h>
#import "XYTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYTableHeaderFooterView : UITableViewHeaderFooterView

@property(nonatomic, strong)XYHeaderFooterItem *modelItem;
@property(nonatomic, weak)XYTableView *xyTableView;

-(void)initCellView;

-(void)bindData:(XYHeaderFooterItem *)model;


/// tableView高度
/// @param tableView 所在tableview开出来，方便外部比对取用，以及为空的时候设置empty高度
/// @param section section
+(CGFloat)heightForXYHeaderView:(XYTableView *)tableView item:(XYHeaderFooterItem *)item section:(NSInteger )section;

+(CGFloat)heightForXYFooterView:(XYTableView *)tableView item:(XYHeaderFooterItem *)item section:(NSInteger )section;

+(NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
