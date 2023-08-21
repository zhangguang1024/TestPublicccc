//
//  XYTableHeaderCell.m
//  XYBasicClass
//
//  Created by 张光 on 2022/6/30.
//

#import "XYTableHeaderCell.h"
#import "XYCellItem+Common.h"

@interface XYTableHeaderCell()



@end

@implementation XYTableHeaderCell

-(void)initCellView{
    [super initCellView];
    
    self.titleLabel = [UILabel labelWithFont:XYFontBoldMake(16) color:[UIColor colorWithRGBAString:@"222222FF"]];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentView.backgroundColor = [UIColor colorWithRGBAString:@"FFFFFF"];
    self.backgroundColor = [UIColor colorWithRGBAString:@"FFFFFF"];
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

+(CGFloat)heightForXYHeaderView:(XYTableView *)tableView item:(XYHeaderFooterItem *)item section:(NSInteger )section{
    return 60;
}

@end
