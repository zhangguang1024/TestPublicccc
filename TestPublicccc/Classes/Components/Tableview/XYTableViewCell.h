//
//  XYTableViewCell.h
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/28.
//

#import <UIKit/UIKit.h>
#import <XYExtention/XYExtention.h>
#import "XYCellItem.h"
@class XYTableView;
NS_ASSUME_NONNULL_BEGIN

@interface XYTableViewCell : UITableViewCell

@property(nonatomic, weak)XYTableView *xyTableView;
@property(nonatomic, strong, readonly)UIView *bottomLine;

@property(nonatomic, strong)XYCellItem *modelItem;

-(void)initCellView;

-(void)bindData:(XYCellItem *)model;


/// tableView高度
/// @param tableView s所在tableview开出来，方便外部比对取用，以及为空的时候设置empty高度
/// @param indexPath indexPath
+(CGFloat)heightForXYTableViewCell:(XYTableView *)tableView indexPath:(NSIndexPath *)indexPath cellItem:(XYCellItem *)cellItem;

+(NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
