//
//  XYNavigationController.m
//  XYBasicClass
//
//  Created by XXYY on 2021/2/17.
//

#import "XYNavigationController.h"

@interface XYNavigationController ()

@end

@implementation XYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = nil;
}


@end
