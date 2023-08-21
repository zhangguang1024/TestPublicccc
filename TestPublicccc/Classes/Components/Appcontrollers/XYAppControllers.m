//
//  XYAppControllers.m
//  XYExtention
//
//  Created by XXYY on 2021/3/17.
//

#import "XYAppControllers.h"

static XYAppControllers * instance = nil;

@implementation XYAppControllers

@synthesize controllerStack = _controllerStack;

+ (instancetype)sharedAppControllers{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XYAppControllers alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    
    _controllerStack = [[NSMutableArray alloc] initWithCapacity:0];

    return self;
}

/**
 * 记录 Controller 到堆栈中
 */
- (void)recordControllerToStack:(UIViewController *)ctrl {
    if(nil == ctrl || ![ctrl isKindOfClass:[UIViewController class]]){
        return;
    }

    NSNumber *ctrl_flag = @((long)ctrl);
    NSString *ctrl_name = @(object_getClassName(ctrl));

    NSMutableDictionary *save_item = [NSMutableDictionary dictionaryWithCapacity:0];
    
    for (NSDictionary *ctrl_item in _controllerStack) {
        NSNumber *item_flag = ctrl_item[@"flag"];

        if ([item_flag isEqualToNumber:ctrl_flag]) {
            //定义一个临时变量，否则ctrl_item被释放掉
            NSDictionary *tmpItem = ctrl_item;
            [_controllerStack removeObject:ctrl_item];
            [_controllerStack addObject:tmpItem];
            goto exe_print;
        }
    }

    save_item[@"flag"] = ctrl_flag;
    save_item[@"name"] = ctrl_name;

    [_controllerStack addObject:save_item];

exe_print:

    NSLog(@"UIViewController Path: %@", [self getControllerStackPath]);

    return;
}

/**
 * 从堆栈中移除 Controller
 */
- (void)removeControllerFromStack:(UIViewController *)ctrl {
    if(nil == ctrl || ![ctrl isKindOfClass:[UIViewController class]]){
        return;
    }
    
    NSNumber *ctrl_flag = @((long)ctrl);
    NSString *ctrl_name = @(object_getClassName(ctrl));
    
    for (NSDictionary *ctrl_tmp in _controllerStack) {
        NSNumber *item_flag = ctrl_tmp[@"flag"];
        NSString *item_name = ctrl_tmp[@"name"];
        
        if ([item_flag isEqualToNumber:ctrl_flag] && [ctrl_name isEqualToString:item_name]) {
            [_controllerStack removeObject:ctrl_tmp];
            goto exe_print;
        }
    }

exe_print:
    
    // 打印当前 UIViewController 路径到命令行，若需查看当前栈路径，则可打开此处注释
    NSLog(@"UIViewController Path: %@", [self getControllerStackPath]);

    return;
}

/**
 * 获取 Controller 最新激活的
 */
- (UIViewController *)getLastActiveController {
    if (nil == _controllerStack) {
        return nil;
    }
    
    NSDictionary *ctrl_item = [_controllerStack lastObject];
    NSNumber *ctrl_flag = ctrl_item[@"flag"];
    
    return (__bridge UIViewController *)(void *)[ctrl_flag longValue];
}

/**
 * 获取 Controller 堆栈信息
 */
- (NSString *)getControllerStackPath {
    NSMutableString *path = [NSMutableString stringWithCapacity:0];
    
    for (NSDictionary *ctrl_tmp in _controllerStack) {
        NSString *item_name = ctrl_tmp[@"name"];
        [path appendFormat:@"/%@", item_name];
    }
    
    return path;
}

/**
 * 记录 Controller 到堆栈中
 */
+ (void)addController:(UIViewController *)ctrl {
    [[self sharedAppControllers] recordControllerToStack:ctrl];
}

/**
 * 从堆栈中移除 Controller
 */
+ (void)removeController:(UIViewController *)ctrl {
    [[self sharedAppControllers] removeControllerFromStack:ctrl];
}

/**
 * 获取最新激活的 UIViewController
 */
+ (UIViewController *)mostRecentController {
    return [[self sharedAppControllers] getLastActiveController];
}

/**
 * 获取 Controller 堆栈信息
 */
+ (NSString *)stackPath {
    return [[self sharedAppControllers] getControllerStackPath];
}

@end
