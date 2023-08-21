//
//  XYWFCollectionView.m
//  XYBasicClass
//

#import "XYWFCollectionView.h"
#import "Toast.h"
static NSString *kCell = @"CellView";
static NSString *kHeaderCell = @"HeaderView";
static NSString *kFooterCell = @"FooterView";

@interface XYWFCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource,XYWaterFlowLayoutDelegate>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)XYWaterFlowLayout *collectionLayout;
@property(nonatomic, strong)NSArray *dataItems;
@property(nonatomic, strong)NSArray <XYHeaderFooterItem *>*headerDataItems;
@property(nonatomic, strong)NSArray <XYHeaderFooterItem *>*footerDataItems;

@end

@implementation XYWFCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

-(void)customView{
    self.collectionLayout.delegate = self;
    // 设置滑动的时候收键盘
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.dataItems = [NSArray array];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    // 绑定默认
    [self.collectionView registerClass:XYCollectionCell.class forCellWithReuseIdentifier:kCell];
    [self.collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderCell];
    [self.collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterCell];
    
    [self refreshLayout];
}

- (void)refreshLayout{
    if (_collectionLayout.flowLayoutStyle == (XYFlowLayoutStyle)3){
        //每一个最小的正方形单元格的边长
        CGFloat  average = (self.frame.size.width - [self edgeInsetInWaterFlowLayout:self.collectionLayout].left * 2 - 3 * [self columnMarginInWaterFlowLayout:self.collectionLayout])/4.0;
        self.collectionLayout.collectionView.frame = CGRectMake(0, 64, self.frame.size.width, average * 2 + [self rowMarginInWaterFlowLayout:self.collectionLayout] + [self edgeInsetInWaterFlowLayout:self.collectionLayout].top + [self edgeInsetInWaterFlowLayout:self.collectionLayout].bottom);
    }else{
        self.collectionLayout.collectionView.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64);
    }
    [self.collectionLayout.collectionView  reloadData];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
    self.collectionView.backgroundColor = self.backgroundColor;
}

-(void)bindData:(NSArray *)dataItems{
    self.dataItems = dataItems;

    self.collectionView.allowsMultipleSelection = NO;
    // 重新注册一下
    for (NSArray *items in self.dataItems) {
        for (XYCellItem *item in items) {
            if ([item.cellClass respondsToSelector:@selector(cellIdentifier)]) {
                [self.collectionView registerClass:item.cellClass forCellWithReuseIdentifier:[item.cellClass cellIdentifier]];
            }
        }
    }
//    [self.collectionView reloadData];
    [self refreshLayout];
}

-(void)bindHeaderData:(NSArray *)headerItems{
    self.headerDataItems = headerItems;
    for (XYHeaderFooterItem *item in self.headerDataItems) {
        if ([item.cellClass respondsToSelector:@selector(cellIdentifier)]) {
            [self.collectionView registerClass:item.cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[item.cellClass cellIdentifier]];
        }
    }
}

-(void)bindFooterData:(NSArray *)footerItems{
    self.footerDataItems = footerItems;
    for (XYHeaderFooterItem *item in self.footerDataItems) {
        if ([item.cellClass respondsToSelector:@selector(cellIdentifier)]) {
            [self.collectionView registerClass:item.cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[item.cellClass cellIdentifier]];
        }
    }
}

-(XYCellItem *)itemForIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > self.dataItems.count) {
        NSAssert(NO, @"dataSource section can't be empty");
        return [[XYCellItem alloc] init];
    }
    
    NSArray *sectionsItems = self.dataItems[indexPath.section];
    if (indexPath.row > sectionsItems.count) {
        NSAssert(NO, @"dataSource row can't be empty");
        return [[XYCellItem alloc] init];
    }
    
    if ([sectionsItems[indexPath.row] isKindOfClass:XYCellItem.class]) {
        return (XYCellItem *)(sectionsItems[indexPath.row]);
    }
    
    return [[XYCellItem alloc] init];
}

#pragma mark UICollectionViewDelegate, UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataItems.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sectionItems = self.dataItems[section];
    return sectionItems.count;
}

- (void)performBatchUpdates:(void (^ __nullable)(void))updates completion:(void (^ __nullable)(BOOL finished))completion{
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray <NSIndexPath *>*selectsArray = [collectionView indexPathsForSelectedItems];
    NSIndexPath *currentIndex = [selectsArray firstObject];
    if (indexPath.section == currentIndex.section && indexPath.row == currentIndex.row) {
        // 手动执行一次选中
        [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        return NO;
    }
    return YES;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 当前数据源
    XYCellItem *currentItem = [self itemForIndexPath:indexPath];
    XYCollectionCell *cell;
    if ([currentItem.cellClass isSubclassOfClass:XYCollectionCell.class]) {
        cell = (XYCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[currentItem.cellClass cellIdentifier] forIndexPath:indexPath];
    }else{
        NSAssert(NO, @"自定义的XYCellItem 未指定 cellClass!");
        cell = (XYCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[XYCollectionCell cellIdentifier] forIndexPath:indexPath];
    }
    cell.xyCollectionView = self;
    // 绑定数据
    [cell bindData:currentItem];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    XYHeaderFooterItem *item;
    if (kind == UICollectionElementKindSectionHeader) {
        item = self.headerDataItems[indexPath.section];
        
        if (item == nil) {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderCell forIndexPath:indexPath];
            return view;
        }
        
        XYCollectionReusableView *header = (XYCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[item.cellClass cellIdentifier] forIndexPath:indexPath];
        [header bindData:item];
        // zhang.todo 类型不符，暂时没办法合并成同意基类，后面在考虑
//        header.xyCollectionView = self;
        reusableView = header;
    }else if (kind == UICollectionElementKindSectionFooter){
        XYHeaderFooterItem *item = self.footerDataItems[indexPath.section];

        if (item == nil) {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterCell forIndexPath:indexPath];
            return view;
        }
        
        XYCollectionReusableView *footer = (XYCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[item.cellClass cellIdentifier] forIndexPath:indexPath];
        [footer bindData:item];
        // zhang.todo 类型不符，暂时没办法合并成同意基类，后面在考虑
//        footer.xyCollectionView = self;
        reusableView = footer;
    }
    return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCellItem *currentItem = [self itemForIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(XYWFCollectionViewDidSelectIndex:item:)]) {
        [self.delegate XYWFCollectionViewDidSelectIndex:indexPath item:currentItem];
    }
}

#pragma mark -
/**
 返回item的大小
 注意：根据当前的瀑布流样式需知的事项：
 当样式为XYFlowVerticalEqualWidth 传入的size.width无效 ，所以可以是任意值，因为内部会根据样式自己计算布局
 XYFlowHorizontalEqualHeight 传入的size.height无效 ，所以可以是任意值 ，因为内部会根据样式自己计算布局
 XYFlowHorizontalGrid   传入的size宽高都有效， 此时返回列数、行数的代理方法无效，
 XYFlowVerticalEqualHeight 传入的size宽高都有效， 此时返回列数、行数的代理方法无效
 */
- (CGSize)waterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCellItem *currentItem = [self itemForIndexPath:indexPath];
    CGSize size = CGSizeZero;
    // 先取子类的，取不到就用itemSize，方便自定义或者通排
    if ([currentItem.cellClass isSubclassOfClass:XYCollectionCell.class]) {
        if ([currentItem.cellClass respondsToSelector:@selector(cellSizeForIndexPath:item:layout:)]) {
            size = [currentItem.cellClass cellSizeForIndexPath:indexPath item:currentItem layout:self.collectionLayout];
        }
    }
    
    if (size.width == 0 && size.height == 0) {
        size = self.collectionLayout.itemSize;
    }
    return size;
}

/** 头视图Size */
-(CGSize )waterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section{
    XYHeaderFooterItem *item = self.headerDataItems[section];

    // zhang.todo sizeForXYHeaderView考虑更改为collectionView
    if ([item.cellClass respondsToSelector:@selector(sizeForXYHeaderView:section:item:)]) {
        return [item.cellClass sizeForXYHeaderView:self.collectionView section:section item:item];
    }
    return self.collectionLayout.headerReferenceSize;
}
/** 脚视图Size */
-(CGSize )waterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section{
    XYHeaderFooterItem *item = self.footerDataItems[section];

    // zhang.todo sizeForXYHeaderView考虑更改为collectionView
    if ([item.cellClass respondsToSelector:@selector(sizeForXYFooterView:section:item:)]) {
        return [item.cellClass sizeForXYFooterView:self.collectionView section:section item:item];
    }
    return self.collectionLayout.footerReferenceSize;
}

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout{
    return self.collectionLayout.minimumLineSpacing;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout{
    return self.collectionLayout.minimumInteritemSpacing;;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout{
    return self.collectionLayout.sectionInset;
}

#pragma mark lazyload
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:self.collectionLayout];
        [_collectionView registerClass:XYCollectionCell.class forCellWithReuseIdentifier:[XYCollectionCell cellIdentifier]];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(XYWaterFlowLayout *)collectionLayout{
    if(_collectionLayout == nil){
        _collectionLayout = [[XYWaterFlowLayout alloc] init];
        _collectionLayout.flowLayoutStyle = XYFlowVerticalEqualWidth;
        //用来给section中的内容设置边距
        _collectionLayout.minimumLineSpacing = 8;             //不同行间的间距
        _collectionLayout.minimumInteritemSpacing = 8;      //同一列中的两个item的间距
        _collectionLayout.headerReferenceSize = CGSizeMake(UIScreen.screenWidth, 0);  //sectionheader的size
        _collectionLayout.footerReferenceSize = CGSizeMake(UIScreen.screenWidth, 0);  //sectionfooter的size
        _collectionLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        //用来给section中的内容设置边距
        _collectionLayout.columnCount = 3;
        _collectionLayout.rowCount = 5;
    }
    return _collectionLayout;
}

@end
