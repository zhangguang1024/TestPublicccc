//
//  XYCellItem+ADD.h
//  Pods
//
//  Created by 张光 on 2022/7/21.
//

#ifndef XYCellItem_ADD_h
#define XYCellItem_ADD_h

/** 定义一个系统内部的键值 */
#define DATA_SYS_KEY(key)                           @"<&" @#key @"&>"

/** 添加一个函数声明 */
#define _DEFINE_DATA_FUNC_INTERNAL(name, dataType)  \
                                                    -(void)set##name:(dataType)value; \
                                                    -(dataType)get##name; \
                                                    +(NSString *)key##name; \
                                                    -(BOOL)has##name;

/** 添加一个函数定义 */
#define _IMPLEMENT_DATA_FUNC_INTERNAL(name, dataType, funForType, strKey) \
                                                    -(void)set##name:(dataType)value { \
                                                        [self set##funForType:value forKey:strKey]; \
                                                    } \
                                                    -(dataType)get##name { \
                                                        return [self get##funForType:strKey]; \
                                                    } \
                                                    +(NSString *)key##name { \
                                                        return strKey; \
                                                    }\
                                                    -(BOOL)has##name {\
                                                        return [self hasKey:strKey]; \
                                                    }

#pragma mark -
#pragma mark 普通函数

/** 返回值为 NSString 的普通函数 */
#define DEFINE_DATA_STR_FUNC(name)                  _DEFINE_DATA_FUNC_INTERNAL(name, NSString *)
#define IMPLEMENT_DATA_STR_FUNC(name, strKey)       _IMPLEMENT_DATA_FUNC_INTERNAL(name, NSString *, String, strKey)

/** 返回值为 int 的普通函数 */
#define DEFINE_DATA_INT_FUNC(name)                  _DEFINE_DATA_FUNC_INTERNAL(name, int)
#define IMPLEMENT_DATA_INT_FUNC(name, strKey)       _IMPLEMENT_DATA_FUNC_INTERNAL(name, int, Int, strKey)

/** 返回值为 BOOL 的普通函数 */
#define DEFINE_DATA_BOOL_FUNC(name)                  _DEFINE_DATA_FUNC_INTERNAL(name, BOOL)
#define IMPLEMENT_DATA_BOOL_FUNC(name, strKey)       _IMPLEMENT_DATA_FUNC_INTERNAL(name, BOOL, Bool, strKey)

#pragma mark -
#pragma mark 数据节点函数

/** 返回值为 NSString 的数据节点函数 */
#define DEFINE_NODE_STR_FUNC(name)                   _DEFINE_DATA_FUNC_INTERNAL(_##name, NSString *)
#define IMPLEMENT_NODE_STR_FUNC(name)                _IMPLEMENT_DATA_FUNC_INTERNAL(_##name, NSString *, String, @#name)

/** 返回值为 int 的数据节点函数 */
#define DEFINE_NODE_INT_FUNC(name)                   _DEFINE_DATA_FUNC_INTERNAL(_##name, int)
#define IMPLEMENT_NODE_INT_FUNC(name)                _IMPLEMENT_DATA_FUNC_INTERNAL(_##name, int, Int, @#name)

/** 返回值为 float 的数据节点函数 */
#define DEFINE_NODE_FLOAT_FUNC(name)                   _DEFINE_DATA_FUNC_INTERNAL(_##name, float)
#define IMPLEMENT_NODE_FLOAT_FUNC(name)                _IMPLEMENT_DATA_FUNC_INTERNAL(_##name, float, Float, @#name)

/** 返回值为 Integer 的数据节点函数 */
#define DEFINE_NODE_INTEGER_FUNC(name)                   _DEFINE_DATA_FUNC_INTERNAL(_##name, NSInteger)
#define IMPLEMENT_NODE_INTEGER_FUNC(name)                _IMPLEMENT_DATA_FUNC_INTERNAL(_##name, NSInteger, Integer, @#name)

/** 返回值为 BOOL 的数据节点函数 */
#define DEFINE_NODE_BOOL_FUNC(name)                  _DEFINE_DATA_FUNC_INTERNAL(_##name, BOOL)
#define IMPLEMENT_NODE_BOOL_FUNC(name)               _IMPLEMENT_DATA_FUNC_INTERNAL(_##name, BOOL, Bool, @#name)

/** 返回值为 NSArray 的数据节点函数 */
#define DEFINE_NODE_ARRAY_FUNC(name)                  _DEFINE_DATA_FUNC_INTERNAL(_##name, NSArray *)
#define IMPLEMENT_NODE_ARRAY_FUNC(name)               _IMPLEMENT_DATA_FUNC_INTERNAL(_##name, NSArray *, Array, @#name)

#pragma mark -
#pragma mark 系统函数

/** 返回值为 NSString 的系统函数 */
#define IMPLEMENT_SYS_STR_FUNC(name)                _IMPLEMENT_DATA_FUNC_INTERNAL(name, NSString *, String, DATA_SYS_KEY(name))

/** 返回值为 int 的系统函数 */
#define IMPLEMENT_SYS_INT_FUNC(name)                _IMPLEMENT_DATA_FUNC_INTERNAL(name, int, Int, DATA_SYS_KEY(name))

/** 返回值为 BOOL 的系统函数 */
#define IMPLEMENT_SYS_BOOL_FUNC(name)               _IMPLEMENT_DATA_FUNC_INTERNAL(name, BOOL, Bool, DATA_SYS_KEY(name))

#endif /* XYCellItem_ADD_h */
