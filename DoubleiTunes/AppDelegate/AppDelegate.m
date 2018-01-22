//
//  AppDelegate.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/16.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "AppDelegate.h"
#import "DTBaseNavigationController.h"
#import "DTAccountViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[DTBaseNavigationController alloc] initWithRootViewController:[[DTAccountViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
