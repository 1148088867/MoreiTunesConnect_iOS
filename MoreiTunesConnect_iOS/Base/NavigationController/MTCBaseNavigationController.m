//
//  MTCBaseNavigationController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCBaseNavigationController.h"

@interface MTCBaseNavigationController ()

@end

@implementation MTCBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
