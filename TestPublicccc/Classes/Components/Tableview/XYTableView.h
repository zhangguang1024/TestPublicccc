//
//  XYTableView.h
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/28.
//

#import <UIKit/UIKit.h>
#import <XYExtention/XYExtention.h>
#import "XYTableViewCell.h"
#import "XYTableHeaderFooterView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol XYTableViewDelegate <NSObject>


/// 选中代理
/// @param tableView tableView开出来，外部还是有可能需要的
/// @param indexPath indexPath
/// @param item item选中数据源
-(void)XYTableViewDidSelect:(XYTableView *)tableView indexPath:(NSIndexPath *)indexPath item:(XYCellItem *)item;

// 滑动代理
-(void)XYTableViewDidScrollow:(XYTableView *)tableView;

@end

@interface XYTableView : UIView

@property(nonatomic, weak)id<XYTableViewDelegate> delegate;

@property(nonatomic, strong, readonly)UITableView *tableView;

// isHeaderSuspension header是否悬浮
-(instancetype)initWithFrame:(CGRect)frame isHeaderSuspension:(BOOL)isHeaderSuspension;


/**  dataItems 数据类型为以下样式（刷新）
 @[
     @[item,item],
     @[item,item],
     @[item,item]
 ];
 */
-(void)bindData:(NSArray *)dataItems;

/**  dataItems 数据类型为以下样式(不刷新，需在bindData前绑定)
 @[
     @[item,item],
     @[item,item],
     @[item,item]
 ];
 */
-(void)bindHeaderData:(NSArray <XYHeaderFooterItem *>*)dataItems;

/**  dataItems 数据类型为以下样式(不刷新，需在bindData前绑定)
 @[
     @[item,item],
     @[item,item],
     @[item,item]
 ];
 */
-(void)bindFooterData:(NSArray <XYHeaderFooterItem *>*)dataItems;

@end




NS_ASSUME_NONNULL_END
