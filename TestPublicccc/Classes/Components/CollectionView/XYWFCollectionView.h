//
//  XYWFCollectionView.h
//  XYBasicClass
//

#import <UIKit/UIKit.h>
#import "XYCollectionCell.h"
#import "XYCollectionReusableView.h"
#import "XYWaterFlowLayout.h"
NS_ASSUME_NONNULL_BEGIN

@protocol XYWFCollectionViewDelegate <NSObject>

// 选中代理
-(void)XYWFCollectionViewDidSelectIndex:(NSIndexPath *)indexPath item:(XYCellItem *)item;

@end


@interface XYWFCollectionView : UIView

@property(nonatomic, weak)id<XYWFCollectionViewDelegate> delegate;

@property(nonatomic, strong, readonly)UICollectionView *collectionView;

@property(nonatomic, strong, readonly)XYWaterFlowLayout *collectionLayout;

/**  dataItems 数据类型为以下样式
 @[
     @[item,item],
     @[item,item],
     @[item,item]
 ];
 */
-(void)bindData:(NSArray *)dataItems;


/**  headerItems 数据类型为以下样式
 @[
     dict,
     dict,
     dict
 ];
 */
-(void)bindHeaderData:(NSArray <XYHeaderFooterItem *>*)headerItems;

/**  footerItems 数据类型为以下样式
 @[
     dict,
     dict,
     dict
 ];
 */
-(void)bindFooterData:(NSArray <XYHeaderFooterItem *>*)footerItems;

@end

NS_ASSUME_NONNULL_END
