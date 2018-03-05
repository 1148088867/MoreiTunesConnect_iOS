//
//  MTCBaseTabBarViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/5.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCBaseTabBarViewController.h"
#import "MTCBaseNavigationController.h"
#import "MTCAccountViewController.h"
#import "MTCSetViewController.h"

@interface MTCBaseTabBarViewController ()

@end

@implementation MTCBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:[[MTCAccountViewController alloc] init] imgName:@"账号列表" title:@"AccountCenter"];
    [self addChildViewController:[[MTCSetViewController alloc] init] imgName:@"设置" title:@"Setting"];
}

- (void)addChildViewController:(MTCBaseViewController *)childController imgName:(NSString *)imgName title:(NSString *)title {
    childController.tabBarItem.image = UIImageMake(imgName);
    MTCBaseNavigationController *navigationController = [[MTCBaseNavigationController alloc] initWithRootViewController:childController];
    childController.title = title;
    [self addChildViewController:navigationController];
}

@end
