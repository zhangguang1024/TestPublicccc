//
//  XYCollectionView.m
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/28.
//

#import "XYCollectionView.h"
#import "Toast.h"
static NSString *kCell = @"CellView";
static NSString *kHeaderCell = @"HeaderView";
static NSString *kFooterCell = @"FooterView";

@interface XYCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *collectionLayout;
@property(nonatomic, strong)NSArray *dataItems;
@property(nonatomic, strong)NSArray <XYHeaderFooterItem *>*headerDataItems;
@property(nonatomic, strong)NSArray <XYHeaderFooterItem *>*footerDataItems;

@end

@implementation XYCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

-(void)customView{
    // 默认总数只能选1个，此时为单选
    self.multipleType = XYCollectionMultipleSelectTypeAll;
    self.multipleCount = 1;
    
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
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
    self.collectionView.backgroundColor = self.backgroundColor;
}

-(void)bindData:(NSArray *)dataItems{
    self.dataItems = dataItems;
    
    if (self.multipleCount < 1) {
        NSAssert(NO, @"必须有一个可选,需要多选时bindData之前multipleType和multipleCount可以设置下");
    }
    
    // 设置多选
    if (self.multipleType == XYCollectionMultipleSelectTypeAll && self.multipleCount == 1) {
        self.collectionView.allowsMultipleSelection = NO;
    }else{
        self.collectionView.allowsMultipleSelection = YES;
    }
    
    // 重新注册一下
    for (NSArray *items in self.dataItems) {
        for (XYCellItem *item in items) {
            if ([item.cellClass respondsToSelector:@selector(cellIdentifier)]) {
                [self.collectionView registerClass:item.cellClass forCellWithReuseIdentifier:[item.cellClass cellIdentifier]];
            }
        }
    }
    [self.collectionView reloadData];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSIndexPath *indexPath = [self currentIndexPath];
    if ([self.delegate respondsToSelector:@selector(XYCollectionViewDidScrollowIndexPath:)] && indexPath) {
        [self.delegate XYCollectionViewDidScrollowIndexPath:indexPath];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (!scrollView.dragging && !scrollView.decelerating) {
            [self scrollViewDidEndScroll];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!scrollView.dragging && !scrollView.decelerating) {
        [self scrollViewDidEndScroll];
    }
}

// 滑动停止时再检测
- (void)scrollViewDidEndScroll {
    NSIndexPath *indexPath = [self currentIndexPath];
    if ([self.delegate respondsToSelector:@selector(XYCollectionViewEndScrollowWithIndex:)] && indexPath) {
        [self.delegate XYCollectionViewEndScrollowWithIndex:indexPath];
    }
}

-(void)selectindexPath:(NSIndexPath *)indexPath{
    if (self.collectionView.allowsMultipleSelection) {
        [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        return;
    }
    
    NSArray *selectedArray = [self.collectionView indexPathsForSelectedItems];
    for (NSIndexPath *currentIndexPath in selectedArray) {
        [self.collectionView deselectItemAtIndexPath:currentIndexPath animated:YES];
    }
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}

-(NSIndexPath *)currentIndexPath{
    CGPoint point;
    if (self.collectionLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        point = CGPointMake(self.collectionView.contentOffset.x, self.collectionLayout.sectionInset.top + self.collectionLayout.itemSize.height/2.0f);
        
        if (point.x <= 0) {
            point.x = self.collectionLayout.sectionInset.left;
        }else if (point.x >= self.collectionView.contentSize.width){
            point.x = self.collectionView.contentSize.width - self.collectionLayout.sectionInset.right;
        }
    }else{
        point = CGPointMake(self.collectionLayout.sectionInset.left + self.collectionLayout.itemSize.width/2.0f, self.collectionView.contentOffset.y);
        
        if (point.y <= 0) {
            point.y = self.collectionLayout.sectionInset.top;
        }else if (point.y >= self.collectionView.contentSize.height){
            point.y = self.collectionView.contentSize.height - self.collectionLayout.sectionInset.bottom;
        }
    }
    
    return [self.collectionView indexPathForItemAtPoint:point];
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

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray <NSIndexPath *>*selectsArray = [collectionView indexPathsForSelectedItems];
    NSString *failString = @"";
    if ([self.datasource respondsToSelector:@selector(XYCollectionViewMultipleSelectedFail)]) {
        failString = [self.datasource XYCollectionViewMultipleSelectedFail];
    }
    
    // 单选时
    if (!self.collectionView.allowsMultipleSelection) {
        for (NSIndexPath *currentIndexPath in selectsArray) {
            [self.collectionView deselectItemAtIndexPath:currentIndexPath animated:YES];
        }
        return YES;
    }
    
    // 多选逻辑
    switch (self.multipleType) {
        case XYCollectionMultipleSelectTypeAll:{
            if (selectsArray.count >= self.multipleCount) {
                // 弹出toast
                if (!XYEmpty(failString)) {
                    [self.collectionView makeToast:failString duration:2 position:CSToastPositionCenter];
                }
                return NO;
            }
        }break;
        case XYCollectionMultipleSelectTypeSection:{
            // 找到当前section
            NSMutableArray *sectionSelectsArray = [NSMutableArray array];
            for (NSIndexPath *selectedIndexPath in selectsArray) {
                if (selectedIndexPath.section == indexPath.section) {
                    [sectionSelectsArray addObject:selectedIndexPath];
                }
            }
            //
            if (sectionSelectsArray.count >= self.multipleCount) {
                if (self.multipleCount == 1) {
                    // 单个的时候，取消原来的选中项，选中当前这个
                    for (NSIndexPath *sectionIndexPath in sectionSelectsArray) {
                        [self.collectionView deselectItemAtIndexPath:sectionIndexPath animated:YES];
                    }
                    return YES;
                }else{
                    // 弹出toast
                    if (!XYEmpty(failString)) {
                        [self.collectionView makeToast:failString duration:2 position:CSToastPositionCenter];
                    }
                    return NO;
                }
            }
        }break;
            
        default:
            break;
    }
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray <NSIndexPath *>*selectsArray = [collectionView indexPathsForSelectedItems];
    // 单选时 或者单section单选时
    if (!self.collectionView.allowsMultipleSelection || (self.multipleType == XYCollectionMultipleSelectTypeSection && self.multipleCount == 1)) {
        NSIndexPath *currentIndex = [selectsArray firstObject];
        if (indexPath.section == currentIndex.section && indexPath.row == currentIndex.row) {
            // 手动执行一次选中
            [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
            return NO;
        }
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
        header.xyCollectionView = self;
        reusableView = header;
    }else if (kind == UICollectionElementKindSectionFooter){
        XYHeaderFooterItem *item = self.footerDataItems[indexPath.section];
        
        if (item == nil) {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kFooterCell forIndexPath:indexPath];
            return view;
        }
        
        XYCollectionReusableView *footer = (XYCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[item.cellClass cellIdentifier] forIndexPath:indexPath];
        [footer bindData:item];
        footer.xyCollectionView = self;
        reusableView = footer;
    }
    return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCellItem *currentItem = [self itemForIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(XYCollectionViewDidSelectIndex:item:)]) {
        [self.delegate XYCollectionViewDidSelectIndex:indexPath item:currentItem];
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
//定制itemSize
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
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

//定制section的inset
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return self.collectionLayout.sectionInset;
}

//定制lineSpacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.collectionLayout.minimumLineSpacing;
}

//定制itemSpacing
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.collectionLayout.minimumInteritemSpacing;
}

//定制headView的Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    XYHeaderFooterItem *item = self.headerDataItems[section];
    
    if ([item.cellClass respondsToSelector:@selector(sizeForXYHeaderView:section:item:)]) {
        return [item.cellClass sizeForXYHeaderView:self.collectionView section:section item:item];
    }
    return self.collectionLayout.headerReferenceSize;
}

//定制footerView的Size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    XYHeaderFooterItem *item = self.footerDataItems[section];
    
    if ([item.cellClass respondsToSelector:@selector(sizeForXYFooterView:section:item:)]) {
        return [item.cellClass sizeForXYFooterView:self.collectionView section:section item:item];
    }
    return self.collectionLayout.footerReferenceSize;
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

-(UICollectionViewFlowLayout *)collectionLayout{
    if(_collectionLayout == nil){
        _collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionLayout.minimumLineSpacing = 8;             //不同行间的间距
        _collectionLayout.minimumInteritemSpacing = 8;      //同一列中的两个item的间距
        _collectionLayout.headerReferenceSize = CGSizeMake(UIScreen.screenWidth, 0);  //sectionheader的size
        _collectionLayout.footerReferenceSize = CGSizeMake(UIScreen.screenWidth, 0);  //sectionfooter的size
        CGFloat itemWidth = (UIScreen.screenWidth - 70) * 0.5;
        _collectionLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        _collectionLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        //用来给section中的内容设置边距
    }
    return _collectionLayout;
}

@end
