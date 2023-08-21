//
//  XYCustomTabbar.m
//  XYBasicClass
//
//  Created by XXYY on 2021/3/14.
//

#import "XYCustomTabbar.h"
#import <XYExtention/XYExtention.h>
@interface XYCustomTabbar()

@property (strong, nonatomic) UIButton *centerButton;
@property (strong, nonatomic) UIView *lineView;

@end

@implementation XYCustomTabbar

- (instancetype)initWithCenterImage:(NSString *)centerImage selectImage:(NSString *)selectImage target:(id)target action:(SEL)action {
    if (self = [super init]) {
        self.centerButtonSpace = -14;
        self.itemCount = 3;
        self.userInteractionEnabled = YES;
        self.tintColor = [UIColor grayColor];
        self.translucent = YES;
        self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.centerButton setBackgroundImage:[UIImage imageNamed:centerImage] forState:UIControlStateNormal];
        [self.centerButton setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
        [self.centerButton setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        [self.centerButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.centerButton];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self customTabbar];
    }
    return self;
}

-(void)customTabbar{
    self.centerButtonSpace = -14;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
    self.lineView.backgroundColor = RGBA(0xff, 0xff, 0xff, 0.7);
    self.lineView.layer.shadowColor = RGBA(0x00, 0x00, 0x00, 0.1).CGColor;
    self.lineView.layer.shadowOffset = CGSizeMake(0, 2.0);
    self.lineView.layer.shadowOpacity = 0.30;
    self.lineView.layer.shadowRadius = 1.0;
    self.lineView.clipsToBounds = NO;
    [self addSubview:self.lineView];
}

-(void)setIsHiddenTopLine:(BOOL)isHiddenTopLine{
    _isHiddenTopLine = isHiddenTopLine;
    self.lineView.hidden = isHiddenTopLine;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.centerButton) {
        CGFloat centerW = self.centerButton.currentBackgroundImage.size.width;
        CGFloat centerH = self.centerButton.currentBackgroundImage.size.height;
        
        self.centerButton.frame = CGRectMake((self.frame.size.width-centerW)/2, self.centerButtonSpace, centerW, centerH);
        CGFloat itemW  = self.frame.size.width / self.itemCount;
        CGFloat itemIndex = 0;
        // 计算每个item位置
        for (UIView *child in self.subviews) {
            Class class = NSClassFromString(@"UITabBarButton");
            if ([child isKindOfClass:class]) {
                child.frame = CGRectMake(itemIndex *itemW, child.frame.origin.y, itemW, child.frame.size.height);
                itemIndex ++;
                if (itemIndex == self.itemCount/2 && self.centerButton) {
                    itemIndex ++;
                }
            }
        }
    }
    
    self.lineView.height = 3;
    self.lineView.width = self.width;
    self.lineView.backgroundColor = [UIColor blackColor];
}


#pragma mark - 重写hitTest方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   // 1. isHidden==NO 表示当前在tabbar页面
    if (self.isHidden == NO) {
        // 1.1 获取触摸点坐标系转化到centerButton上的CGPoint
        CGPoint newPoint = [self convertPoint:point toView:self.centerButton];
        // 1.2 判断point是否在centerButton上，如果在，centerButton来处理点击事件
        if ( [self.centerButton pointInside:newPoint withEvent:event]) {
            return self.centerButton;
        }
        // 1.3 如不在，系统自行处理
        else{
            return [super hitTest:point withEvent:event];
        }
    }
    // 2. 不在tabbar页面，系统自行处理点击事件
    else {
        return [super hitTest:point withEvent:event];
    }
}

@end
