//
//  XYCollectionCell.m
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/28.
//

#import "XYCollectionCell.h"
#import "XYCollectionView.h"
@interface XYCollectionCell()

@end

@implementation XYCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCellView];
    }
    return self;
}

-(void)initCellView{
    
}

-(void)bindData:(XYCellItem *)model{
    self.cellItem = model;
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

+(CGSize)cellSizeForIndexPath:(NSIndexPath *)indexPath item:(XYCellItem *)item layout:(UICollectionViewFlowLayout *)layout{
    return CGSizeZero;
}

@end
