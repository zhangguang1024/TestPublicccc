//
//  XYWFCollectionCell.m
//  XYBasicClass
//

#import "XYWFCollectionCell.h"
#import "XYWaterFlowLayout.h"

@implementation XYWFCollectionCell

+(CGSize)cellSizeForIndexPath:(NSIndexPath *)indexPath item:(XYCellItem *)item layout:(XYWaterFlowLayout *)layout{
//     = 0, /** 竖向瀑布流 item等宽不等高 */
//     = 1, /** 水平瀑布流 item等高不等宽 不支持头脚视图*/
//     = 2,  /** 竖向瀑布流 item等高不等宽 */
//     = 3,  /** 特为国务院客户端原创栏目滑块样式定制-水平栅格布局  仅供学习交流*/
//     = 4 /** 线性布局 待完成，敬请期待 */
    CGSize size = CGSizeMake(0, 0);
    switch (layout.flowLayoutStyle) {
        case XYFlowVerticalEqualWidth:{
            size = CGSizeMake(0, arc4random()%20);
        }break;
        case XYFlowHorizontalEqualHeight:{
            size = CGSizeMake(arc4random()%20, 0);
        }break;
        case XYFlowVerticalEqualHeight:{
            size = CGSizeMake(arc4random()%20, 0);
        }break;
        case XYFlowHorizontalGrid:{
            // zhang.todo 回头再补充,暂时不要用这个类型
        }break;
        case XYFlowLineWaterFlow:{
            // zhang.todo 回头再补充,暂时不要用这个类型
        }break;
        default:
            break;
    }
    
    return CGSizeZero;
}

@end
