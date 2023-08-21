//
//  XYEmptyCollectionHeaderFooterCell.m
//  XYBasicClass
//
//  Created by 张光 on 2022/7/30.
//

#import "XYEmptyCollectionHeaderFooterCell.h"

@implementation XYEmptyCollectionHeaderFooterCell

+(CGSize)sizeForXYFooterView:(UICollectionView *)collectionView section:(NSInteger)section item:(XYHeaderFooterItem *)item{
    return CGSizeMake(0.02, 0.02);
}

+(CGSize)sizeForXYHeaderView:(UICollectionView *)collectionView section:(NSInteger)section item:(XYHeaderFooterItem *)item{
    return CGSizeMake(0.02, 0.02);
}

@end
