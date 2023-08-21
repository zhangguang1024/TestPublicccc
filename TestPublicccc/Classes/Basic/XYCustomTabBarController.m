//
//  XYCustomTabBarController.m
//  XYBasicClass
//
//  Created by XXYY on 2021/3/14.
//

#import "XYCustomTabBarController.h"
#import "XYNavigationController.h"
@interface XYCustomTabBarController ()

@end

@implementation XYCustomTabBarController

-(instancetype)init{
    self = [super init];
    if (self) {
        [self customInit];
    }
    return self;
}

-(void)customInit{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTabbarView];
}

-(void)customTabbarView{
    // 未设置时默认添加普通样式 & 默认三个
    if (!self.customTabbar) {
        // 添加中间凸出的item
    //    self.customTabbar = [[XYCustomTabbar alloc]initWithCenterImage:@"youjiantou" selectImage:@"zuojiantou" target:self action:@selector(centerButtonClick)];
        // 添加平常样式的item
        self.customTabbar = [[XYCustomTabbar alloc] init];
        self.customTabbar.itemCount = 3;
    }
    
    [self setValue:self.customTabbar forKey:@"tabBar"];
}

#pragma mark - 添加子控制器
-(void)setViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    static NSInteger index = 0;
    viewController.tabBarItem.title = title;
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.tag = index;
    index++;
    XYNavigationController *nav = [[XYNavigationController alloc]initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

- (void)centerButtonClick {
    NSLog(@"中间突出的按钮");
//    CenterViewController *centerVC = [[CenterViewController alloc]init];
//    [self presentViewController:centerVC animated:YES completion:nil];
}

@end
