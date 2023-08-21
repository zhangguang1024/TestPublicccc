//
//  XYCollectionView.h
//  FBSnapshotTestCase
//
//  Created by XXYY on 2021/2/28.
//

#import <UIKit/UIKit.h>
#import "XYCollectionCell.h"
#import "XYCollectionReusableView.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,XYCollectionMultipleSelectType){
    XYCollectionMultipleSelectTypeAll,      // 默认collection 总共可选multipleCount个
    XYCollectionMultipleSelectTypeSection   // 每个scection 可选multipleCount个
};

@protocol XYCollectionViewDelegate <NSObject>

// 选中代理
-(void)XYCollectionViewDidSelectIndex:(NSIndexPath *)indexPath item:(XYCellItem *)item;

@optional
// currentIndexPath 变化代理
-(void)XYCollectionViewDidScrollowIndexPath:(NSIndexPath *)indexPath;
// 停止滑动代理
-(void)XYCollectionViewEndScrollowWithIndex:(NSIndexPath *)indexPath;

@end


@protocol XYCollectionViewDatasource <NSObject>

@optional
// 多选失败时的文案
-(NSString *)XYCollectionViewMultipleSelectedFail;

@end

@interface XYCollectionView : UIView

@property(nonatomic, weak)id<XYCollectionViewDelegate> delegate;
@property(nonatomic, weak)id<XYCollectionViewDatasource> datasource;

@property(nonatomic, strong, readonly)UICollectionView *collectionView;

/**
 * multipleType 与multipleCount 配合使用。
 * multipleType:all multipleCount:1 正常单选 (也是默认值)
 * multipleType:all multipleCount:>1 正常多选
 * multipleType:Section multipleCount:1 每个section只能有一个选中。注：选择新的时候，老的会被取消选中
 * multipleType:Section multipleCount:>1 每个section可选multipleCount个
 */
@property(nonatomic, assign)XYCollectionMultipleSelectType multipleType;  // 默认all
@property(nonatomic, assign)NSInteger multipleCount;     // 默认1

// 外部可以更改配置
@property(nonatomic, strong, readonly)UICollectionViewFlowLayout *collectionLayout;

// 选中某一个
-(void)selectindexPath:(NSIndexPath *)indexPath;

/**  dataItems 数据类型为以下样式
 @[
     @[item,item],
     @[item,item],
     @[item,item]
 ];
 */
-(void)bindData:(NSArray *)dataItems;


/**  headerItems 数据类型为以下样式
 @[
     dict,
     dict,
     dict
 ];
 */
-(void)bindHeaderData:(NSArray <XYHeaderFooterItem *>*)headerItems;

/**  footerItems 数据类型为以下样式
 @[
     dict,
     dict,
     dict
 ];
 */
-(void)bindFooterData:(NSArray <XYHeaderFooterItem *>*)footerItems;

@end

NS_ASSUME_NONNULL_END
