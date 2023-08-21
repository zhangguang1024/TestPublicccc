//
//  XYWaterFlowLayout.h
//  collectionView
//

#import <UIKit/UIKit.h>


typedef enum {
    XYFlowVerticalEqualWidth = 0, /** 竖向瀑布流 item等宽不等高 */
    XYFlowHorizontalEqualHeight = 1, /** 水平瀑布流 item等高不等宽 不支持头脚视图*/
    XYFlowVerticalEqualHeight = 2,  /** 竖向瀑布流 item等高不等宽 */
    XYFlowHorizontalGrid = 3,  /** 特为国务院客户端原创栏目滑块样式定制-水平栅格布局  仅供学习交流*/
    XYFlowLineWaterFlow = 4 /** 线性布局 待完成，敬请期待 */
} XYFlowLayoutStyle; //样式

@class XYWaterFlowLayout;

@protocol XYWaterFlowLayoutDelegate <NSObject>

/**
 返回item的大小
 注意：根据当前的瀑布流样式需知的事项：
 当样式为XYFlowVerticalEqualWidth 传入的size.width无效 ，所以可以是任意值，因为内部会根据样式自己计算布局
 XYFlowHorizontalEqualHeight 传入的size.height无效 ，所以可以是任意值 ，因为内部会根据样式自己计算布局
 XYFlowHorizontalGrid   传入的size宽高都有效， 此时返回列数、行数的代理方法无效，
 XYFlowVerticalEqualHeight 传入的size宽高都有效， 此时返回列数、行数的代理方法无效
 */
- (CGSize)waterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/** 头视图Size */
-(CGSize )waterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section;
/** 脚视图Size */
-(CGSize )waterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout sizeForFooterViewInSection:(NSInteger)section;

@optional //以下都有默认值

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout;
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout;
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(XYWaterFlowLayout *)waterFlowLayout;

@end

@interface XYWaterFlowLayout : UICollectionViewFlowLayout

/** delegate*/
@property (nonatomic, weak) id<XYWaterFlowLayoutDelegate> delegate;
/** 瀑布流样式*/
@property (nonatomic, assign) XYFlowLayoutStyle  flowLayoutStyle;


/** 列数*/
@property(nonatomic, assign)NSInteger columnCount;
/** 行数*/
@property(nonatomic, assign)NSInteger rowCount;

@end
