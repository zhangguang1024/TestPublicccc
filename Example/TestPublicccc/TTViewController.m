//
//  TTViewController.m
//  TestPublicccc
//
//  Created by zhangguang on 08/09/2023.
//  Copyright (c) 2023 zhangguang. All rights reserved.
//

#import "TTViewController.h"
#import "TestViewController.h"
@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:btn];
    
    btn.center = CGPointMake(200, 380);
}

-(void)clickBtn{
    TestViewController *vc = [[TestViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
