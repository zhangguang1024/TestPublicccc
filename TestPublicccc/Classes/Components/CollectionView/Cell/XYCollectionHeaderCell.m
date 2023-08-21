//
//  XYCollectionHeaderCell.m
//  XYBasicClass
//
//  Created by 张光 on 2022/6/30.
//

#import "XYCollectionHeaderCell.h"
#import "XYCellItem+Common.h"

@interface XYCollectionHeaderCell()

@end

@implementation XYCollectionHeaderCell

-(void)initReusableView{
    [super initReusableView];
    
    self.titleLabel = [UILabel labelWithFont:XYFontBoldMake(16) color:[UIColor colorWithRGBAString:@"222222FF"]];
    [self addSubview:self.titleLabel];
}

-(void)bindData:(XYHeaderFooterItem *)model{
    [super bindData:model];
    
    self.titleLabel.text = [model get_title];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.width = self.width - 16*2;
    [self.titleLabel autoFitHeight];
    self.titleLabel.left = 16;
    self.titleLabel.centerY = self.height/2.0f;
}

+(CGSize)sizeForXYHeaderView:(UICollectionView *)collectionView section:(NSInteger )section item:(XYHeaderFooterItem *)item{
    return CGSizeMake(UIScreen.screenWidth, 60);
}

@end
