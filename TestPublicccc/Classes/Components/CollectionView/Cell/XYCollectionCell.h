//
//  XYCollectionCell.h
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/28.
//

#import <UIKit/UIKit.h>
#import "XYExtention/XYExtention.h"
#import "XYCellItem.h"
@class XYCollectionView;
NS_ASSUME_NONNULL_BEGIN

@interface XYCollectionCell : UICollectionViewCell

@property(weak)XYCollectionView *xyCollectionView;
@property(nonatomic, strong)XYCellItem *cellItem;


-(void)initCellView;
-(void)bindData:(XYCellItem *)model;

+(NSString *)cellIdentifier;

// 子类可以自定义高度(返回CGSizeZero时，使用layout中的值，基类默认返回CGSizeZero)
+(CGSize)cellSizeForIndexPath:(NSIndexPath *)indexPath item:(XYCellItem *)item layout:(UICollectionViewFlowLayout *)layout;


@end

NS_ASSUME_NONNULL_END
