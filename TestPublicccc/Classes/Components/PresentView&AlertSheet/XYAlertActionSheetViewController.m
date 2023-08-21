//
//  XYAlertActionSheetViewController.m
//

#import "XYAlertActionSheetViewController.h"
#import "XYActionSheetTransition.h"

#pragma mark - XYAlertActionSheetCell
@interface XYAlertActionSheetCell ()

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *subTitleLabel;

- (void)bindCellData:(XYAlertSheetAction *)action;

@end


@interface XYAlertSheetAction ()

@property (nonatomic, copy, nullable) void (^handler)(XYAlertSheetAction *action);

@property (nonatomic, strong, nullable) NSDictionary *item;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy, nullable) NSString *subTitle;

@end

@interface XYAlertActionSheetViewController ()<UITableViewDelegate, UITableViewDataSource,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *actionView;

@property (nonatomic, strong) NSMutableArray<XYAlertSheetAction *> *actions;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XYAlertActionSheetViewController

- (void)customView {
    [super customView];
    
    self.customNavBarView.hidden = YES;
    self.transitioningDelegate = self;
    self.modalPresentationCapturesStatusBarAppearance = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.contentView addSubview:self.actionView];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.cancelButton];

    [self.actionView reloadData];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    if (title.length <= 0) {
        [self.titleLabel removeFromSuperview];
    } else {
        [self.contentView addSubview:self.titleLabel];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat contentWidth = self.view.width - 2 * 8.0f;
    CGFloat contentLeft = 8.0f;
    CGFloat contentBottom = 8.0f + ([UIDevice isIPhoneXseries] ? 34.0f : 0.0f);
    self.cancelButton.width = contentWidth;
    self.cancelButton.left = contentLeft;
    self.cancelButton.top = self.view.height - contentBottom - self.cancelButton.height;

    CGFloat actionViewHeight = [self actionViewHeight];
    if (self.titleLabel.superview == self.contentView) {
        self.contentView.height = actionViewHeight + self.titleLabel.height;
    } else {
        self.contentView.height = actionViewHeight;
    }
    self.contentView.left = contentLeft;
    self.contentView.width = contentWidth;
    self.contentView.bottom = self.cancelButton.top - 8.0f;

    self.actionView.left = 0;
    self.actionView.height = actionViewHeight;
    self.actionView.width = contentWidth;
    self.actionView.bottom = self.contentView.height;
}

- (void)addAction:(XYAlertSheetAction *)action {
    if (action == nil) {
        return;
    }
    [self.actions addObject:action];
}

- (void)addActions:(NSArray<XYAlertSheetAction *> *)actions {
    if (actions == nil ) {
        return;
    }
    [self.actions addObjectsFromArray:actions];
}

- (CGFloat)actionViewHeight {
    __block CGFloat height = 0.0f;

    [self.actions enumerateObjectsUsingBlock:^(XYAlertSheetAction *  _Nonnull action, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger cellHeight = [self heightOfAction:action];
        height += (cellHeight + 1.0f / UIScreen.mainScreen.scale);
    }];

    CGFloat maxHeight = UIScreen.screenHeight * 0.618;
    self.actionView.scrollEnabled = height > maxHeight;

    return MIN(height,maxHeight);
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

#pragma mark - UITableView Delegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYAlertActionSheetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"kAlertActionCommonCell" forIndexPath:indexPath];
    [cell bindCellData:self.actions[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= self.actions.count) {
        return;
    }

    XYAlertSheetAction *action = self.actions[indexPath.row];
    [self dismissViewControllerAnimated:YES completion:^{
        if (action.handler) {
            action.handler(action);
            action.handler = nil;
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYAlertSheetAction *action = self.actions[indexPath.row];
    return [self heightOfAction:action];
}

- (CGFloat)heightOfAction:(XYAlertSheetAction *)action {
    if (action.subTitle.length <= 0) {
        return [self configCellHeight] + 1.0f / UIScreen.screenScale;;
    }

    CGFloat height = 8;
    CGFloat maxWidth = UIScreen.screenWidth - 32.0f;

    UIFont *titleFont = [XYAlertActionSheetCell appearance].titleFont;
    CGSize titleSize = [action.subTitle xySizeWithMaxWidth:maxWidth font:titleFont];
    height += titleSize.height;

    if (!(action.subTitle.length<=0)) {
        height += 8;
        UIFont *subTitleFont = [XYAlertActionSheetCell appearance].subTitleFont;
        CGSize subTitleSize = [action.subTitle xySizeWithMaxWidth:maxWidth font:subTitleFont];
        height += subTitleSize.height;
    }
    height += (8 + 1.0f / UIScreen.screenScale);
    return MAX([self configCellHeight],ceilf(height));
}

#pragma mark -- UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    XYActionSheetTransition *transition = [[XYActionSheetTransition alloc] initWithPresent:YES animationView:self.contentView];
    transition.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.55f];
    return transition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[XYActionSheetTransition alloc] initWithPresent:NO animationView:self.contentView];
}

#pragma mark -

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.layer.cornerRadius = 8.0f;
        _contentView.clipsToBounds = YES;
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}

- (UITableView *)actionView {
    if (!_actionView) {
        _actionView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _actionView.scrollEnabled = NO;
        _actionView.delegate = self;
        _actionView.dataSource = self;
        _actionView.separatorColor = [UIColor colorWithRGBAString:@"f0f0f0"];
        _actionView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.screenWidth, 1.0f / UIScreen.screenScale)];
        [_actionView registerClass:XYAlertActionSheetCell.class forCellReuseIdentifier:@"kAlertActionCommonCell"];
    }
    return _actionView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        UIFont *cancelTitleFont = [self configCancelButtonFont];
        UIColor *cancelTitleColor = [self configCancelButtonColor];
        _cancelButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:cancelTitleColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = cancelTitleFont;
        _cancelButton.layer.cornerRadius = 8.0f;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.height = [self configCellHeight];
        _cancelButton.width = [UIScreen screenWidth] - 16.0f;
        _cancelButton.backgroundColor = UIColor.whiteColor;
        [_cancelButton addTarget:self action:@selector(closeViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {

        UIFont *titleFont = [self configCellFont];
        UIColor *titleColor = [self configCellColor];
        _titleLabel = [UILabel labelWithFont:titleFont color:titleColor];
        _titleLabel.height = 48.0f;
        _titleLabel.width = UIScreen.screenWidth - 2 * 8.0f;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        UIView *line = [[UIView alloc] initWithFrame:_titleLabel.bounds];
        line.height = 1.0f / UIScreen.screenScale;
        line.top = 48.0f - line.height;
        line.backgroundColor = self.actionView.separatorColor;
        [_titleLabel addSubview:line];
    }
    return _titleLabel;
}

-(NSMutableArray <XYAlertSheetAction *>*)actions{
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

#pragma mark - config
-(CGFloat)configCellHeight{
    return 52;
}

-(UIColor *)configCellColor{
    return [UIColor colorWithRGBAString:@"666666"];
}

-(UIFont *)configCellFont{
    return XYFontMake(14);
}

-(UIColor *)configCancelButtonColor{
    return [UIColor colorWithRGBAString:@"222222"];
}

-(UIFont *)configCancelButtonFont{
    return XYFontBoldMake(16);
}

@end

#pragma mark - AlertActionCell

@implementation XYAlertActionSheetCell

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setDefaultAppearance];
    });
}

+ (void)setDefaultAppearance {
    XYAlertActionSheetCell *appearance = [XYAlertActionSheetCell appearance];
    appearance.titleColor = [UIColor colorWithRGBAString:@"222222"];
    appearance.subTitleColor = [UIColor colorWithRGBAString:@"999999"];
    appearance.titleFont = [UIFont boldSystemFontOfSize:16.0f];
    appearance.subTitleFont = [UIFont systemFontOfSize:12.0f];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    self.titleColor = [XYAlertActionSheetCell appearance].titleColor;
    self.subTitleColor = [XYAlertActionSheetCell appearance].subTitleColor;
    self.titleFont = [XYAlertActionSheetCell appearance].titleFont;
    self.subTitleFont = [XYAlertActionSheetCell appearance].subTitleFont;

    self.separatorInset = UIEdgeInsetsZero;
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRGBAString:@"f0f0f0"];

    self.titleLabel = [UILabel labelWithFont:self.titleFont color:self.titleColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.height = [self.titleFont lineHeight];

    self.subTitleLabel = [UILabel labelWithFont:self.subTitleFont color:self.subTitleColor];
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.numberOfLines = 0;

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
}

- (void)bindCellData:(XYAlertSheetAction *)action {
    self.titleLabel.textColor = action.titleColor ?: self.titleColor;
    self.subTitleLabel.textColor = action.subTitleColor ?: self.subTitleColor;

    self.titleLabel.text = action.title;
    self.subTitleLabel.text = action.subTitle;
    self.subTitleLabel.hidden = (action.subTitle <= 0);
    self.tag = action.tag;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelLeft = 16.0f;
    CGFloat labelW = self.contentView.width - 2 * labelLeft;
    self.titleLabel.width = labelW;
    self.titleLabel.left = labelLeft;
    if (!self.subTitleLabel.hidden) {
        self.subTitleLabel.width = labelW;
        [self.subTitleLabel sizeToFit];

        CGFloat margin = 8.0f;
        self.subTitleLabel.width = labelW;
        self.subTitleLabel.left = labelLeft;
        self.subTitleLabel.top = self.titleLabel.bottom + margin;
        self.titleLabel.top = (self.contentView.height - self.titleLabel.height - self.subTitleLabel.height - margin) / 2.0f;
    } else {
        self.titleLabel.centerY = self.contentView.centerY;
    }
}

@end

#pragma mark - XYAlertSheetAction

@implementation XYAlertSheetAction

+ (instancetype)actionWithTitle:(nullable NSString *)title subTitle:(nullable NSString *)subTitle handler:(void (^ __nullable)(XYAlertSheetAction *action))handler {
    XYAlertSheetAction *action = [[XYAlertSheetAction alloc] init];
    action.title = title;
    action.subTitle = subTitle;
    action.handler = handler;
    return action;
}

+ (instancetype)actionWithItem:(NSDictionary *)item handler:(void (^ __nullable)(XYAlertSheetAction *action))handler {
    XYAlertSheetAction *action = [[XYAlertSheetAction alloc] init];
    action.title = [item valueForKey:@"title"];

    UIColor *titleColor = item[@"titleColor"];
    if ([titleColor isKindOfClass:UIColor.class]) {
        action.titleColor = titleColor;
    }

    action.subTitle = [item valueForKey:@"subTitle"];
    UIColor *subTitleColor = item[@"subTitleColor"];
    if ([subTitleColor isKindOfClass:UIColor.class]) {
        action.subTitleColor = titleColor;
    }

    action.handler = handler;
    return action;
}

@end


#pragma mark - AlertActionItem

@implementation NSDictionary (AlertActionItem)

/// 警告单元格数据配置
+ (NSDictionary *)warningItemWithTitle:(nullable NSString *)title {
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    [item setValue:title forKey:@"title"];
    [item setValue:[UIColor colorWithRGBAString:@"e74c3c"] forKey:@"titleColor"];
    return item;
}

@end
