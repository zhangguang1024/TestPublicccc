//
//  XYCellItem+Common.h
//  XYBasicClass
//
//  Created by 张光 on 2022/7/21.
//

#import "XYCellItem.h"
#import "XYCellItem+ADD.h"
NS_ASSUME_NONNULL_BEGIN

@interface XYCellItem (Common)

DEFINE_NODE_STR_FUNC(title);
DEFINE_NODE_STR_FUNC(subTitle);
DEFINE_NODE_STR_FUNC(key);
DEFINE_NODE_STR_FUNC(value);
DEFINE_NODE_STR_FUNC(identifier);
DEFINE_NODE_STR_FUNC(tag);
DEFINE_NODE_STR_FUNC(customString);
DEFINE_NODE_STR_FUNC(customSubString);

DEFINE_NODE_INTEGER_FUNC(index);
DEFINE_NODE_INTEGER_FUNC(customInteger);

DEFINE_NODE_BOOL_FUNC(status);
DEFINE_NODE_BOOL_FUNC(isOn);
DEFINE_NODE_BOOL_FUNC(customBool);

DEFINE_NODE_STR_FUNC(imageUrl);
DEFINE_NODE_STR_FUNC(imageString);
DEFINE_NODE_STR_FUNC(url);

// array
DEFINE_NODE_ARRAY_FUNC(tagsItems);

@end

NS_ASSUME_NONNULL_END
