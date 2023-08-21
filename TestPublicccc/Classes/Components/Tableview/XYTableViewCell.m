//
//  XYTableViewCell.m
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/28.
//

#import "XYTableViewCell.h"
@interface XYTableViewCell()

@property(nonatomic, strong)UIView *bottomLine;

@end

@implementation XYTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}

-(void)initCellView{
    [self.contentView addSubview:self.bottomLine];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bottomLine.bottom = self.height;
    self.bottomLine.centerX = self.width/2.0f;
}

// 子类实现赋值
-(void)bindData:(XYCellItem *)model{
    self.modelItem = model;
}

+(CGFloat)heightForXYTableViewCell:(XYTableView *)tableView indexPath:(NSIndexPath *)indexPath cellItem:(XYCellItem *)cellItem{
    return 44;
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

-(UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.screenWidth, 1)];
        _bottomLine.backgroundColor = ColorWithHexString(@"#DCDCDC");
    }
    return _bottomLine;
}

@end
