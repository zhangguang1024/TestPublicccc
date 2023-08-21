//
//  XYEmptyTableHeaderFooterCell.m
//  XYBasicClass
//
//  Created by 张光 on 2022/7/30.
//

#import "XYEmptyTableHeaderFooterCell.h"

@implementation XYEmptyTableHeaderFooterCell

+(CGFloat)heightForXYFooterView:(XYTableView *)tableView item:(XYHeaderFooterItem *)item section:(NSInteger)section{
    return 0.02;
}

+(CGFloat)heightForXYHeaderView:(XYTableView *)tableView item:(XYHeaderFooterItem *)item section:(NSInteger)section{
    return 0.02;
}

@end
