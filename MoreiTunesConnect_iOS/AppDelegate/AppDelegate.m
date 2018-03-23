//
//  AppDelegate.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/16.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "AppDelegate.h"
#import "FanYiSDK.h"
#import <DWNetworking.h>
#import <IQKeyboardManager.h>
#import <JSPatchPlatform/JSPatch.h>
#import "MTCBaseTabBarViewController.h"
#import <AFNetworkActivityIndicatorManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupAllConfig];
    return YES;
}

- (void)setupAllConfig {
    [self JSPConfig];
    [self YDYFYConfig];
    [self NetworkConfig];
    [self IQKeyboardConfig];
    [self RootViewControllerConfig];
}

- (void)JSPConfig {
    [JSPatch startWithAppKey:MTCJSPKey];
    [JSPatch setupRSAPublicKey:MTCJSPPUBLICKey];
    [JSPatch sync];
}

- (void)YDYFYConfig {
    [[YDTranslateInstance sharedInstance] setAppKey:MTCYDYFYKey];
}

- (void)NetworkConfig {
    MTCNetworkConfig
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

- (void)IQKeyboardConfig {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)RootViewControllerConfig {
    self.window = [[UIWindow alloc] initWithFrame:ScreenBounds];
    self.window.rootViewController = [[MTCBaseTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
}

@end
