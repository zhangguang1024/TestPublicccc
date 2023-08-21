//
//  XYCustomButtonView.m
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/25.
//

#import "XYCustomButtonView.h"

@interface XYCustomButtonView()

@property(nonatomic, strong)UIControl *touchControl;

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UIImageView *subImageView;
@property(nonatomic, strong)UIImageView *bgView;

@property(nonatomic, assign)CGFloat buttonWidth;

@end

@implementation XYCustomButtonView

-(instancetype)initWithWidth:(CGFloat)buttonWidth{
    self  = [super initWithFrame:CGRectMake(0, 0, buttonWidth, 0)];
    self.buttonWidth = buttonWidth;
    if (self) {
        [self customView];
    }
    return self;
}

-(void)customView{
    
    self.bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.bgView];
    
    self.imageTextSpace = 4;
    self.buttonInsets = UIEdgeInsetsMake(8, 16, 8, 16);
    self.buttonType = XYButtonPositionTypeDefault;
    self.minHeight = 0;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.imageView];
    [self addSubview:self.subImageView];
    [self addSubview:self.touchControl];
}

-(void)setTag:(NSInteger)tag{
    [super setTag:tag];
    self.touchControl.tag = tag;
}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [self.touchControl addTarget:target action:action forControlEvents:controlEvents];
}

- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state{
    self.bgView.image = image;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.bgView.frame = self.bounds;
    self.touchControl.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.subImageView.hidden = YES;
    self.imageView.hidden = NO;
    
    //
    CGFloat contentHeight;
    if (self.buttonType == XYButtonPositionTypeTypeTop || self.buttonType == XYButtonPositionTypeTypeBottom) {
        contentHeight = self.imageView.height + self.titleLabel.height + self.imageTextSpace;
    }else{
        contentHeight = MAX(MAX(self.imageView.height, self.subImageView.height), self.titleLabel.height) + self.imageTextSpace;
    }
    
    // 计算间距 间距上下评分，可以通过控制 buttonInsets调整居上还是拒下
    CGFloat space = (self.height - self.buttonInsets.top - self.buttonInsets.bottom - contentHeight)/2.0f;
    CGFloat top = self.buttonInsets.top + space;
    
    switch (self.buttonType) {
        case XYButtonPositionTypeDefault:{
            self.imageView.hidden = YES;
            self.titleLabel.center = CGPointMake(self.width/2.0f, self.height/2.0f);
        }break;
        case XYButtonPositionTypeTypeLeft:{
            self.imageView.left = self.buttonInsets.left;
            [self.titleLabel rightOfView:self.imageView withMargin:self.imageTextSpace];
            if (self.imageView.height > self.titleLabel.height) {
                self.imageView.top = top;
                [self.titleLabel sameHorizontalMidLineOfView:self.imageView];
            }else{
                self.titleLabel.top = top;
                [self.imageView sameHorizontalMidLineOfView:self.titleLabel];
            }
        }break;
        case XYButtonPositionTypeTypeRight:{
            self.titleLabel.left = self.buttonInsets.left;
            [self.imageView rightOfView:self.titleLabel withMargin:self.imageTextSpace];
            if (self.imageView.height > self.titleLabel.height) {
                self.imageView.top = top;
                [self.titleLabel sameHorizontalMidLineOfView:self.imageView];
            }else{
                self.titleLabel.top = top;
                [self.imageView sameHorizontalMidLineOfView:self.titleLabel];
            }
        }break;
        case XYButtonPositionTypeTypeTop:{
            self.imageView.top = top;
            self.imageView.centerX = self.titleLabel.centerX = self.width/2.0f;
            [self.titleLabel bottomOfView:self.imageView withMargin:self.imageTextSpace];
        }break;
        case XYButtonPositionTypeTypeBottom:{
            self.titleLabel.top = top;
            self.imageView.centerX = self.titleLabel.centerX = self.width/2.0f;
            [self.imageView bottomOfView:self.titleLabel withMargin:self.imageTextSpace];
        }break;
        case XYButtonPositionTypeLeftAndRight:{
            self.subImageView.hidden = NO;
            self.imageView.left = self.buttonInsets.left;
            CGFloat maxHeight = MAX(MAX(self.imageView.height, self.subImageView.height), self.titleLabel.height);
            self.imageView.centerY = self.titleLabel.centerY = self.subImageView.centerY = (top + maxHeight/2.0f);
            [self.titleLabel rightOfView:self.imageView withMargin:self.imageTextSpace];
            [self.subImageView rightOfView:self.titleLabel withMargin:self.imageTextSpace];
        }break;
            
        default:
            break;
    }
}

-(void)updateSubViews{
    [self autoFitHeight];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

// 计算高度
-(void)autoFitHeight{
    CGFloat buttonHeight;
    CGFloat titleWidth;
    
    buttonHeight = self.buttonInsets.top + self.buttonInsets.bottom;
    switch (self.buttonType) {
        case XYButtonPositionTypeDefault:{
            titleWidth = self.buttonWidth - self.buttonInsets.left - self.buttonInsets.right;
        }break;
        case XYButtonPositionTypeTypeLeft:{
            titleWidth = self.buttonWidth - self.buttonInsets.left - self.buttonInsets.right - self.imageTextSpace - self.imageView.width;
        }break;
        case XYButtonPositionTypeTypeRight:{
            titleWidth = self.buttonWidth - self.buttonInsets.left - self.buttonInsets.right - self.imageTextSpace - self.imageView.width;
        }break;
        case XYButtonPositionTypeTypeTop:{
            titleWidth = self.buttonWidth - self.buttonInsets.left - self.buttonInsets.right;
            buttonHeight += self.imageView.height + self.imageTextSpace;
        }break;
        case XYButtonPositionTypeTypeBottom:{
            titleWidth = self.buttonWidth - self.buttonInsets.left - self.buttonInsets.right;
            buttonHeight += self.imageView.height + self.imageTextSpace;
        }break;
        case XYButtonPositionTypeLeftAndRight:{
            titleWidth = self.buttonWidth - self.buttonInsets.left - self.buttonInsets.right - self.imageTextSpace - self.imageView.width - self.imageTextSpace - self.subImageView.width;
        }break;
            
        default:
            break;
    }
    
    self.titleLabel.width = titleWidth;
    [self.titleLabel sizeToFit];
    self.titleLabel.width = titleWidth;
    
    if (self.buttonType == XYButtonPositionTypeTypeLeft || self.buttonType == XYButtonPositionTypeTypeRight) {
        buttonHeight += MAX(self.imageView.height, self.titleLabel.height);
    }else if (self.buttonType == XYButtonPositionTypeLeftAndRight){
        buttonHeight += MAX(MAX(self.imageView.height, self.subImageView.height), self.titleLabel.height);
    }else{
        buttonHeight += self.titleLabel.height;
    }
    
    self.height = MAX(buttonHeight, self.minHeight);
}

#pragma mark - lazyload
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UIImageView *)subImageView{
    if (_subImageView == nil) {
        _subImageView = [[UIImageView alloc] init];
    }
    return _subImageView;
}

-(UIControl *)touchControl{
    if (_touchControl == nil) {
        _touchControl = [[UIControl alloc] init];
    }
    return _touchControl;
}


@end
