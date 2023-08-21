//
//  XYCellItem.h
//  XYBasicClass
//
//  Created by ZG on 2021/3/18.
//

#import <Foundation/Foundation.h>

/// 子类若添加属性，请重写copyWithZone，把自己添加的属性补充上去
@interface XYCellItem : NSObject<NSCopying>

@property (readonly) NSMutableDictionary *dictData;
@property(nonatomic, assign)Class cellClass;
@property(nonatomic, strong)NSString *identifier;

+(XYCellItem *)cellItem;

/** 追加一个 DataItemDetail 对象的值 */
- (void)append:(XYCellItem *)item;

/** 追加一个 NSDictionary 对象的值 */
- (void)appendDict:(NSDictionary *)dict;

/** 获取节点int值 */
- (int)getItemInt;

/** 获取节点布尔值 */
- (BOOL)getItemBool;

/** 设置节点字符串值 */
- (BOOL)setItemText:(NSString *)value;

/** 设置节点int值 */
- (BOOL)setItemInt:(int)value;

/** 设置节点布尔值 */
- (BOOL)setItemBool:(BOOL)value;

/** 获取节点字符串属性值 */
- (NSString *)getItemAttribute:(NSString *)attributeKey;

/** 获取节点int属性值 */
- (int)getItemIntAttribute:(NSString *)attributeKey;

/** 获取节点布尔属性 */
- (BOOL)getItemBoolAttribute:(NSString *)attributeKey;

/** 设定节点字符串属性值 */
- (BOOL)setItemAttribute:(NSString *)attributeKey attributeValue:(NSString *)attributeValue;

/** 设定节点int属性值 */
- (BOOL)setItemIntAttribute:(NSString *)attributeKey attributeValue:(int)attributeValue;

/** 设定节点布尔属性 */
- (BOOL)setItemBoolAttribute:(NSString *)attributeKey attributeValue:(BOOL)attributeValue;

/** 获取字符串值 */
- (NSString *)getString:(NSString *)key;

/* 获取数组值 */
- (NSArray *)getArray:(NSString *)key;

/** 获取int值 */
- (int)getInt:(NSString *)key;

/** 获取float值 */
- (float)getFloat:(NSString *)key;

/** 获取NSInteger值 */
- (NSInteger)getInteger:(NSString *)key;

/** 获取long long值 */
- (long long)getLongLong:(NSString *)key;

/** 获取布尔值 */
- (BOOL)getBool:(NSString *)key;

/** 设定字符串值 */
- (BOOL)setString:(NSString *)value forKey:(NSString *)key;

/* 设定数组 */
- (BOOL)setArray:(NSArray *)value forKey:(NSString *)key;

/** 设定 long long 值 */
- (BOOL)setLongLong:(long long)value forKey:(NSString *)key;

/** 设定int值 */
- (BOOL)setInt:(int)value forKey:(NSString *)key;

/** 设定float值 */
- (BOOL)setFloat:(float)value forKey:(NSString *)key;

/** 设定Integer值 */
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key;

/** 设定布尔值 */
- (BOOL)setBool:(BOOL)value forKey:(NSString *)key;

/** 是否存在键值对 */
- (BOOL)hasKey:(NSString *)key;

/** 是否存在匹配的键值对 */
- (BOOL)hasKey:(NSString *)key withValue:(NSString *)value;

/** 是否存在属性键值对 */
- (BOOL)hasAttribute:(NSString *)key nodeName:(NSString *)nodeName;

/** 是否存在匹配的属性键值对 */
- (BOOL)hasAttribute:(NSString *)key nodeName:(NSString *)nodeName withValue:(NSString *)value;

/* 清除所有元素 */
- (void)clear;

@end


// 区分开cellItem
@interface XYHeaderFooterItem : XYCellItem<NSCopying>

@end
