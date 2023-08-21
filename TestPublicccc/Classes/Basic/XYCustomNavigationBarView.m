// 
/*
 FileName: XYCustomNavigationBarView.m
  Program: 
   Author: zhangguang
    Group: XXYY
     Time: 2020/12/20
    Notes: 自定义导航栏view
 */

#import "XYCustomNavigationBarView.h"

@interface XYCustomNavigationBarView()

@property(nonatomic, strong)UILabel  *titleLabel;   // 宽度顶满了，外界可以设置alligent控制排版

@end

@implementation XYCustomNavigationBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

-(void)customView{
    // 设置默认值
    _style = XYNavBarStyleNormal;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.titleLabel];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    self.leftButton.hitEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    [self.leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [self addSubview:self.leftButton];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.screenWidth, 1)];
    self.bottomLine.backgroundColor = [ColorWithHexString(@"#92A0B1") colorWithAlphaComponent:0.2];
    self.bottomLine.hidden = YES;
    [self addSubview:self.bottomLine];
}

-(void)layoutSubviews{
    [super layoutSubviews];

    CGFloat statusHeight = 20;
    if ([UIDevice isIPhoneNotchScreen]) {
        statusHeight = 44;
    }
    
    if (self.leftButton.hidden) {
        self.leftButton.width = 0;
    }
    
    if (self.rightButton.hidden) {
        self.rightButton.width = 0;
    }
    
    self.leftButton.left = self.leftSpace;
    self.leftButton.centerY = (self.height + statusHeight)/2.0f;
    
    self.rightButton.right = self.width - self.rightSpace;
    self.rightButton.centerY = self.leftButton.centerY;
    
    [self.titleLabel sizeToFit];
    CGFloat maxWidth = self.width - self.leftSpace - MAX(self.leftButton.width, self.rightButton.width)*2 - 8 - 8 - self.rightSpace;
    self.titleLabel.width = maxWidth;
    self.titleLabel.centerY = self.leftButton.centerY;
    
    if (self.style == XYNavBarStyleLeft && self.leftButton.hidden) {
        self.titleLabel.left = self.leftSpace;
    }else{
        self.titleLabel.centerX = self.width/2.0f;
    }
    
    self.bottomLine.left = 0;
    self.bottomLine.bottom = self.height;
}

-(void)setLeftButton:(UIButton *)leftButton{
    [_leftButton removeFromSuperview];
    
    _leftButton = leftButton;
    [self addSubview:_leftButton];
    [_leftButton sizeToFit];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setRightButton:(UIButton *)rightButton{
    [_rightButton removeFromSuperview];
    
    _rightButton = rightButton;
    [self addSubview:_rightButton];
    [_rightButton sizeToFit];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setStyle:(XYNavBarStyle)style{
    _style = style;
    
    switch (style) {
        case XYNavBarStyleNormal:{
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }break;
        case XYNavBarStyleLeft:{
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
        }break;
        case XYNavBarStyleRight:{
            self.titleLabel.textAlignment = NSTextAlignmentRight;
        }break;
            
        default:
            break;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabel.text = titleString;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    _titleLabel.font = titleFont;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(CGFloat)leftSpace{
    if (_leftSpace <= 0) {
        return 16;
    }
    return _leftSpace;
}

-(CGFloat)rightSpace{
    if (_rightSpace <= 0) {
        return 16;
    }
    return _rightSpace;
}


@end
