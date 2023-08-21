//
//  XYTableView.m
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/28.
//

#import "XYTableView.h"
#import "XYTableViewCell.h"
#import "XYTableHeaderFooterView.h"
@interface XYTableView()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSArray *cellDataItems;
@property(nonatomic, strong)NSArray <XYHeaderFooterItem *>*headerItems;
@property(nonatomic, strong)NSArray <XYHeaderFooterItem *>*footerItems;

@property(nonatomic, assign) BOOL isHeaderSuspension;       // 默认NO，不悬浮

@end


@implementation XYTableView

-(instancetype)initWithFrame:(CGRect)frame isHeaderSuspension:(BOOL)isHeaderSuspension{
    self = [super initWithFrame:frame];
    if (self) {
        _isHeaderSuspension = isHeaderSuspension;
        [self customView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isHeaderSuspension = NO;
        [self customView];
    }
    return self;
}

-(void)customView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:_isHeaderSuspension?UITableViewStylePlain:UITableViewStyleGrouped];
    if (!_isHeaderSuspension) {
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    // 设置滑动的时候收键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    [self.tableView registerClass:XYTableViewCell.class forCellReuseIdentifier:[XYTableViewCell cellIdentifier]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.width, self.height);
}

-(void)bindHeaderData:(NSArray *)dataItems{
    self.headerItems = dataItems;
    // 重新注册一下
    for (XYHeaderFooterItem *item in self.headerItems) {
        if ([item.cellClass respondsToSelector:@selector(cellIdentifier)]) {
            [self.tableView registerClass:item.cellClass forHeaderFooterViewReuseIdentifier:[item.cellClass cellIdentifier]];
        }
    }
}

-(void)bindFooterData:(NSArray *)dataItems{
    self.footerItems = dataItems;
    // 重新注册一下
    for (XYHeaderFooterItem *item in dataItems) {
        if ([item.cellClass respondsToSelector:@selector(cellIdentifier)]) {
            [self.tableView registerClass:item.cellClass forHeaderFooterViewReuseIdentifier:[item.cellClass cellIdentifier]];
        }
    }
}

-(void)bindData:(NSArray *)dataItems;{
    self.cellDataItems = dataItems;
    // 重新注册一下
    for (NSArray *items in self.cellDataItems) {
        for (XYCellItem *item in items) {
            if ([item.cellClass respondsToSelector:@selector(cellIdentifier)]) {
                [self.tableView registerClass:item.cellClass forCellReuseIdentifier:[item.cellClass cellIdentifier]];
            }
        }
    }
    
    [self.tableView reloadData];
}

-(XYCellItem *)itemForIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > self.cellDataItems.count) {
        NSAssert(NO, @"dataSource section can't be empty");
        return [[XYCellItem alloc] init];
    }
    
    NSArray *sectionsItems = self.cellDataItems[indexPath.section];
    if (indexPath.row > sectionsItems.count) {
        NSAssert(NO, @"dataSource row can't be empty");
        return [[XYCellItem alloc] init];
    }
    
    if ([sectionsItems[indexPath.row] isKindOfClass:XYCellItem.class]) {
        return (XYCellItem *)(sectionsItems[indexPath.row]);
    }
    
    return [[XYCellItem alloc] init];
}


#pragma mark UITableViewDelegate, UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sectionItems = self.cellDataItems[section];
    return sectionItems.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellDataItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 当前数据源
    XYCellItem *currentItem = [self itemForIndexPath:indexPath];
    XYTableViewCell *cell;
    if ([currentItem.cellClass isSubclassOfClass:XYTableViewCell.class]) {
        cell = (XYTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[currentItem.cellClass cellIdentifier]];
        if (cell == nil) {
            cell = [[currentItem.cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[currentItem.cellClass cellIdentifier]];
        }
    }else{
        cell = (XYTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[XYTableViewCell cellIdentifier]];
        if (cell == nil) {
            cell = [[XYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[XYTableViewCell cellIdentifier]];
        }
    }
    cell.xyTableView = self;
    // 绑定数据
    [cell bindData:currentItem];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYCellItem *item = [self itemForIndexPath:indexPath];
    
    if ([item.cellClass respondsToSelector:@selector(heightForXYTableViewCell:indexPath:cellItem:)]) {
        return [item.cellClass heightForXYTableViewCell:self indexPath:indexPath cellItem:item];
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.headerItems.count <= section) {
        return nil;
    }
    
    XYHeaderFooterItem *currentHeaderItem = [self.headerItems objectAtIndex:section];
    XYTableHeaderFooterView *headerView = [[currentHeaderItem.cellClass alloc] initWithReuseIdentifier:[currentHeaderItem identifier]];
    [headerView bindData:currentHeaderItem];
    headerView.xyTableView = self;
    return headerView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.footerItems.count <= section) {
        return nil;
    }
    
    XYHeaderFooterItem *currentFooterItem = [self.footerItems objectAtIndex:section];
    XYTableHeaderFooterView *footerView = [[currentFooterItem.cellClass alloc] initWithReuseIdentifier:[currentFooterItem identifier]];
    [footerView bindData:currentFooterItem];
    footerView.xyTableView = self;
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.headerItems.count <= section) {
        return 0;
    }
    
    XYHeaderFooterItem *currentHeaderItem = [self.headerItems objectAtIndex:section];
    if ([currentHeaderItem.cellClass respondsToSelector:@selector(heightForXYHeaderView:item:section:)]) {
        return [currentHeaderItem.cellClass heightForXYHeaderView:self item:currentHeaderItem section:section];
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.footerItems.count <= section) {
        return 0;
    }
    
    XYHeaderFooterItem *currentFooterItem = [self.footerItems objectAtIndex:section];
    if ([currentFooterItem.cellClass respondsToSelector:@selector(heightForXYFooterView:item:section:)]) {
        return [currentFooterItem.cellClass heightForXYFooterView:self item:currentFooterItem section:section];
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(XYTableViewDidSelect:indexPath:item:)]) {
        [self.delegate XYTableViewDidSelect:self indexPath:indexPath item:[self itemForIndexPath:indexPath]];
    }
}

#pragma mark - UIScrollowViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(XYTableViewDidScrollow:)]) {
        [self.delegate XYTableViewDidScrollow:self];
    }
}

@end





