//
//  AppDelegate.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/16.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "AppDelegate.h"
#import "MTCBaseTabBarViewController.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <DWNetworking.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self networkConfig];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[MTCBaseTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)networkConfig {
    [DWNetworking setConfigRequestType:DWRequestTypeJSON responseType:DWResponseTypeJSON];
    [DWNetworking setHttpHeaderConfig:@{@"Connection":@"keep-alive",
                                        @"X-Apple-Widget-Key":@"e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42",
                                        @"Content-Type":@"application/json",
                                        @"Accept":@"application/json, text/javascript, */*; q=0.01",
                                        @"X-Requested-With":@"XMLHttpRequest",
                                        @"Referer":@"https://idmsa.apple.com/appleauth/auth/signin?widgetKey=e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42&widgetDomain=https://itunesconnect.apple.com:443&font=sf",
                                        }];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

@end
