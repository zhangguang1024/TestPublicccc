//
//  XYTableHeaderFooterView.m
//  XYBasicClass
//
//  Created by 张光 on 2022/3/19.
//

#import "XYTableHeaderFooterView.h"

@interface XYTableHeaderFooterView()

@property(nonatomic, strong)UIView *bottomLine;

@end

@implementation XYTableHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
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
-(void)bindData:(XYHeaderFooterItem *)model{
    self.modelItem = model;
}

+(CGFloat)heightForXYHeaderView:(XYTableView *)tableView item:(XYHeaderFooterItem *)item section:(NSInteger )section{
    return 44;
}

+(CGFloat)heightForXYFooterView:(XYTableView *)tableView item:(XYHeaderFooterItem *)item section:(NSInteger )section{
    return 44;
}

+(NSString *)cellIdentifier{
    return NSStringFromClass([self class]);
}

@end
