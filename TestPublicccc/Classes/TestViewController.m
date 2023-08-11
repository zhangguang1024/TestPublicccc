//
//  TestViewController.m
//  TestPublicccc
//
//  Created by ZJS on 2023/8/9.
//

#import "TestViewController.h"

static NSString *frameworkName = @"TestPublicccc";

NSBundle *ImageBundle(void){
    NSString *path = [[NSBundle mainBundle] pathForResource:frameworkName ofType:@"bundle"];//获取文件路径
    if(!path){
        path = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:[NSString stringWithFormat:@"/Frameworks/%@.framework",frameworkName]];
        NSBundle *frameworkBundle = [NSBundle bundleWithPath:path];
        path = [frameworkBundle pathForResource:frameworkName ofType:@"bundle"];
    }
    return [NSBundle bundleWithPath:path];
}

NSBundle *LocalizableBundle(void){
    NSString *path = [[NSBundle mainBundle] pathForResource:frameworkName ofType:@"bundle"];//获取文件路径
    if(!path){
        path = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:[NSString stringWithFormat:@"/Frameworks/%@.framework",frameworkName]];
        NSBundle *frameworkBundle = [NSBundle bundleWithPath:path];
        path = [frameworkBundle pathForResource:frameworkName ofType:@"bundle"];
    }
    
    // 拼接上语言
    path = [path stringByAppendingString:@"/Language/en.lproj"];
    return [NSBundle bundleWithPath:path];
}

// 项目中，请把多语言文件都放在Localizable 下
NSString *ZJLocalized(NSBundle *bundle, NSString *key){
    NSString *value = [bundle localizedStringForKey:key value:nil table:@"Localizable"];
    return value;
}

@interface TestViewController ()

@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UILabel *titleLab;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 250, 0, 0)];
    self.titleLab.text = ZJLocalized(LocalizableBundle(), @"test");
    self.titleLab.textColor = [UIColor blackColor];
    [self.titleLab sizeToFit];
    [self.view addSubview:self.titleLab];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 80, 80)];
    self.imageView.image = [UIImage imageNamed:@"xiong" inBundle:ImageBundle() compatibleWithTraitCollection:nil];
    [self.view addSubview:self.imageView];
}



@end
