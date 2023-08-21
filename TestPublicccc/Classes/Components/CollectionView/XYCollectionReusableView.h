//
//  XYCollectionReusableView.h
//  XYBasicClass
//
//  Created by XXYY on 2021/3/1.
//

#import <UIKit/UIKit.h>
#import "XYCellItem.h"
#import "XYCollectionView.h"
@class XYCollectionView;

NS_ASSUME_NONNULL_BEGIN

@interface XYCollectionReusableView : UICollectionReusableView

@property(weak)XYCollectionView *xyCollectionView;
@property(nonatomic, strong)XYHeaderFooterItem *model;

-(void)initReusableView;

-(void)bindData:(XYHeaderFooterItem *)model;

/// collectionView的size
/// @param collectionView 所在collectionView开出来，方便外部比对取用，以及为空的时候设置empty高度
/// @param section section
+(CGSize)sizeForXYHeaderView:(UICollectionView *)collectionView section:(NSInteger )section item:(XYHeaderFooterItem *)item;

+(CGSize)sizeForXYFooterView:(UICollectionView *)collectionView section:(NSInteger )section item:(XYHeaderFooterItem *)item;

+(NSString *)cellIdentifier;

@end

NS_ASSUME_NONNULL_END
