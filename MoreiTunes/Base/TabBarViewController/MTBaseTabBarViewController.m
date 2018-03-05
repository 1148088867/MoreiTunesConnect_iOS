//
//  MTBaseTabBarViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/5.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTBaseTabBarViewController.h"
#import "MTBaseNavigationController.h"
#import "MTAccountViewController.h"
#import "MTSetViewController.h"

@interface MTBaseTabBarViewController ()

@end

@implementation MTBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController:[[MTAccountViewController alloc] init] imgName:@"账号列表" title:@"AccountCenter"];
    [self addChildViewController:[[MTSetViewController alloc] init] imgName:@"设置" title:@"Setting"];
}

- (void)addChildViewController:(MTBaseViewController *)childController imgName:(NSString *)imgName title:(NSString *)title {
    childController.tabBarItem.image = UIImageMake(imgName);
    MTBaseNavigationController *navigationController = [[MTBaseNavigationController alloc] initWithRootViewController:childController];
    childController.title = title;
    [self addChildViewController:navigationController];
}

@end
