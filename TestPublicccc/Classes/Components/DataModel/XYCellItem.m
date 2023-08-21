//
//  XYCellItem.m
//  XYBasicClass
//
//  Created by ZG on 2021/3/18.
//

#import "XYCellItem.h"

@interface XYCellItem()

@property(nonatomic, strong)NSMutableDictionary *dictData;

@end

@implementation XYCellItem

+(XYCellItem *)cellItem{
    return [[XYCellItem alloc] init];
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _dictData = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone{
    XYCellItem *item = [[XYCellItem alloc] init];
    item.cellClass = self.cellClass;
    item.identifier = self.identifier;
    return item;
}

/** 追加一个 DataItemDetail 对象的值 */
- (void)append:(XYCellItem *)item{
    if (nil == item) {
        return;
    }
    
    if (![item isKindOfClass:[XYCellItem class]]) {
        return;
    }

    NSArray *keys = [NSArray arrayWithArray:[item.dictData allKeys]];
    for (NSString *key in keys) {
        if (nil == item.dictData[key]) {
            continue;
        }
        self.dictData[key] = item.dictData[key];
    }
}

/** 追加一个 NSDictionary 对象的值 */
- (void)appendDict:(NSDictionary *)dict{
    if (nil == dict) {
        return;
    }

    if (![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }

    NSArray *keys = [NSArray arrayWithArray:[dict allKeys]];
    for (NSString *key in keys) {
        if (nil == dict[key]) {
            continue;
        }
        self.dictData[key] = dict[key];
    }
}

/* 获取节点int值 */
- (int)getItemInt {
    return [self getInt:@"text"];
}

/* 获取节点布尔值 */
- (BOOL)getItemBool {
    return [self getBool:@"text"];
}

/* 设置节点字符串值 */
- (BOOL)setItemText:(NSString *)value {
    return [self setString:value forKey:@"text"];
}

/* 设置节点int值 */
- (BOOL)setItemInt:(int)value {
    return [self setInt:value forKey:@"text"];
}

/* 设置节点布尔值 */
- (BOOL)setItemBool:(BOOL)value {
    return [self setBool:value forKey:@"text"];
}

/* 获取节点字符串属性值 */
- (NSString *)getItemAttribute:(NSString *)attributeKey {
    return [self getAttribute:attributeKey nodeName:@"item"];
}

/* 获取节点int属性值 */
- (int)getItemIntAttribute:(NSString *)attributeKey {
    return [self getIntAttribute:attributeKey nodeName:@"item"];
}

/* 获取节点布尔属性 */
- (BOOL)getItemBoolAttribute:(NSString *)attributeKey {
    return [self getBoolAttribute:attributeKey nodeName:@"item"];
}

/* 设定节点字符串属性值 */
- (BOOL)setItemAttribute:(NSString *)attributeKey attributeValue:(NSString *)attributeValue {
    return [self setAttribute:attributeKey attributeValue:attributeValue nodeName:@"item"];
}

/* 设定节点int属性值 */
- (BOOL)setItemIntAttribute:(NSString *)attributeKey attributeValue:(int)attributeValue {
    return [self setIntAttribute:attributeKey attributeValue:attributeValue nodeName:@"item"];
}

/* 设定节点布尔属性 */
- (BOOL)setItemBoolAttribute:(NSString *)attributeKey attributeValue:(BOOL)attributeValue {
    return [self setBoolAttribute:attributeKey attributeValue:attributeValue nodeName:@"item"];
}

/* 获取字符串值 */
- (NSString *)getString:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return @"";
    }

    NSString *value = _dictData[key];

    if(nil == value){
        return @"";
    } else if(![value isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@", value];
    }

    return value;
}

/* 获取数组值 */
- (NSArray *)getArray:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return @[];
    }
    
    NSArray *value = _dictData[key];
    
    if(nil == value){
        return @[];
    } else if(![value isKindOfClass:[NSArray class]]) {
        return @[value];
    }
    
    return value;
}

/* 获取int值 */
- (int)getInt:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return 0;
    }

    NSString *value = _dictData[key];
    if(nil == value){
        return 0;
    }

    if (![value isKindOfClass:[NSString class] ] && ![value isKindOfClass:[NSNumber class]]) {
        return 0;
    }

    return [value intValue];
}

/** 获取float值 */
- (float)getFloat:(NSString *)key{
    if (nil == _dictData || nil == key) {
        return 0;
    }

    NSString *value = _dictData[key];
    if(nil == value){
        return 0;
    }

    if (![value isKindOfClass:[NSString class] ] && ![value isKindOfClass:[NSNumber class]]) {
        return 0;
    }

    return [value floatValue];
}

/** 获取NSInteger值 */
- (NSInteger)getInteger:(NSString *)key{
    if (nil == _dictData || nil == key) {
        return 0;
    }

    NSString *value = _dictData[key];
    if(nil == value){
        return 0;
    }

    if (![value isKindOfClass:[NSString class] ] && ![value isKindOfClass:[NSNumber class]]) {
        return 0;
    }

    return [value integerValue];
}

/* 获取long long值 */
- (long long)getLongLong:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return 0;
    }
    
    NSString *value = _dictData[key];
    if(nil == value){
        return 0;
    }
    
    if (![value isKindOfClass:[NSString class] ] && ![value isKindOfClass:[NSNumber class]]) {
        return 0;
    }
    
    return [value longLongValue];
}

/* 获取布尔值 */
- (BOOL)getBool:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return NO;
    }

    NSString *value = _dictData[key];
    
    if(nil == value){
        return NO;
    }
    
    if([value isKindOfClass:[NSNumber class]]){
        NSNumber *numvalue = (NSNumber *)value;
        return [numvalue boolValue];
    }

    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }

    value = [value lowercaseString];

    if([value isEqualToString:@"y"] || [value isEqualToString:@"on"] || [value isEqualToString:@"yes"] || [value isEqualToString:@"true"]){
        return YES;
    }

    int intValue = [value intValue];

    if (intValue != 0) {
        return YES;
    }

    return NO;
}

/* 设定字符串值 */
- (BOOL)setString:(NSString *)value forKey:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return NO;
    }

    if(nil == value){
        value = @"";
    }

    _dictData[key] = value;

    return YES;
}

/* 设定数组 */
- (BOOL)setArray:(NSArray *)value forKey:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return NO;
    }
    
    if(nil == value){
        value = @[];
    }
    
    _dictData[key] = value;
    
    return YES;
}

/* 设定 long long 值 */
- (BOOL)setLongLong:(long long)value forKey:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return NO;
    }

    _dictData[key] = [NSString stringWithFormat:@"%lld", value];

    return YES;
}

/* 设定int值 */
- (BOOL)setInt:(int)value forKey:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return NO;
    }

    _dictData[key] = [NSString stringWithFormat:@"%d", value];

    return YES;
}

/** 设定float值 */
- (BOOL)setFloat:(float)value forKey:(NSString *)key{
    if (nil == _dictData || nil == key) {
        return NO;
    }
    _dictData[key] = [NSString stringWithFormat:@"%f", value];
    return YES;
}

/** 设定Integer值 */
- (BOOL)setInteger:(NSInteger)value forKey:(NSString *)key{
    if (nil == _dictData || nil == key) {
        return NO;
    }
    _dictData[key] = [NSString stringWithFormat:@"%ld", value];
    return YES;
}

/* 设定布尔值 */
- (BOOL)setBool:(BOOL)value forKey:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return NO;
    }

    _dictData[key] = [NSString stringWithFormat:@"%d", value ? 1 : 0];

    return YES;
}

/* 获取字符串属性 */
- (NSString *)getAttribute:(NSString *)attributeKey nodeName:(NSString *)nodeName {
    if(nil == attributeKey || nil == nodeName){
        return @"";
    }

    return [self getString:[NSString stringWithFormat:@"%@.%@", nodeName, attributeKey]];
}

/* 获取int属性 */
- (int)getIntAttribute:(NSString *)attributeKey nodeName:(NSString *)nodeName {
    if(nil == attributeKey || nil == nodeName){
        return 0;
    }

    return [self getInt:[NSString stringWithFormat:@"%@.%@", nodeName, attributeKey]];
}

/* 获取布尔属性 */
- (BOOL)getBoolAttribute:(NSString *)attributeKey nodeName:(NSString *)nodeName {
    if(nil == attributeKey || nil == nodeName){
        return NO;
    }

    return [self getBool:[NSString stringWithFormat:@"%@.%@", nodeName, attributeKey]];
}

/* 设定字符串属性 */
- (BOOL)setAttribute:(NSString *)attributeKey attributeValue:(NSString *)attributeValue nodeName:(NSString *)nodeName {
    if(nil == attributeKey || nil == nodeName){
        return NO;
    }

    return [self setString:attributeValue forKey:[NSString stringWithFormat:@"%@.%@", nodeName, attributeKey]];
}

/* 设定int属性 */
- (BOOL)setIntAttribute:(NSString *)attributeKey attributeValue:(int)attributeValue nodeName:(NSString *)nodeName {
    if(nil == attributeKey || nil == nodeName){
        return NO;
    }

    return [self setInt:attributeValue forKey:[NSString stringWithFormat:@"%@.%@", nodeName, attributeKey]];
}

/* 设定布尔属性 */
- (BOOL)setBoolAttribute:(NSString *)attributeKey attributeValue:(BOOL)attributeValue nodeName:(NSString *)nodeName {
    if(nil == attributeKey || nil == nodeName){
        return NO;
    }

    return [self setBool:attributeValue forKey:[NSString stringWithFormat:@"%@.%@", nodeName, attributeKey]];
}

/** 是否存在键值对 */
- (BOOL)hasKey:(NSString *)key {
    if (nil == _dictData || nil == key) {
        return NO;
    }

    if (_dictData[key]) {
        return YES;
    }

    return NO;
}

/* 是否存在匹配的键值对 */
- (BOOL)hasKey:(NSString *)key withValue:(NSString *)value {
    if (nil == _dictData || nil == key || nil == value) {
        return NO;
    }

    NSString *tmpValue = _dictData[key];

    if (nil == tmpValue) {
        return NO;
    }

    if(![tmpValue isEqualToString:value]){
        return NO;
    }

    return YES;
}

/* 是否存在属性键值对 */
- (BOOL)hasAttribute:(NSString *)key nodeName:(NSString *)nodeName {
    if (nil == key || nil == nodeName) {
        return NO;
    }

    return [self hasKey:[NSString stringWithFormat:@"%@.%@", nodeName, key]];
}

/* 是否存在匹配的属性键值对 */
- (BOOL)hasAttribute:(NSString *)key nodeName:(NSString *)nodeName withValue:(NSString *)value {
    if (nil == key || nil == nodeName) {
        return NO;
    }

    return [self hasKey:[NSString stringWithFormat:@"%@.%@", nodeName, key] withValue:value];
}

/* 清除所有元素 */
- (void)clear {
    [_dictData removeAllObjects];
}


@end


@implementation XYHeaderFooterItem

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone{
    XYCellItem *item = [[XYCellItem alloc] init];
    item.cellClass = self.cellClass;
    item.identifier = self.identifier;
    return item;
}

@end
