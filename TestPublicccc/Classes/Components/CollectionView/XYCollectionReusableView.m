//
//  XYCollectionReusableView.m
//  XYBasicClass
//
//  Created by XXYY on 2021/3/1.
//

#import "XYCollectionReusableView.h"

@implementation XYCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    if (self) {
        [self initReusableView];
    }
    return self;
}

-(void)initReusableView{
    
}

-(void)bindData:(XYHeaderFooterItem *)model{
    self.model = model;
}

/// collectionView高度
/// @param collectionView 所在collectionView开出来，方便外部比对取用，以及为空的时候设置empty高度
/// @param section section
+(CGSize)sizeForXYHeaderView:(UICollectionView *)collectionView section:(NSInteger )section item:(XYHeaderFooterItem *)item{
    return CGSizeZero;
}

+(CGSize)sizeForXYFooterView:(UICollectionView *)collectionView section:(NSInteger )section item:(XYHeaderFooterItem *)item{
    return CGSizeZero;
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

@end
