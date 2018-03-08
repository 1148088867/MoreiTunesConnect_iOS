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
#import <JSPatchPlatform/JSPatch.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self networkConfig];
    [self JSPConfig];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[MTCBaseTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)networkConfig {
    MTCNetworkConfig
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

- (void)JSPConfig {
    [JSPatch startWithAppKey:@"fcb8e656e6b7f455"];
    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyAguJxAJqcKYrBiHbnKN\n5Z3E8AiD9PMu0BmcQNXaPY0MZIAiyYEZ88DO99QzA9URSVVV8hWF82WngTFhxyRx\nNDRq+FDj62Hzv6yF/NdWCY28TZeJ+/V0OW4TeEjGMqTe3eDty0VzPhbaBFpaFsu5\nsl1Nx/WHLHe1ydR4hKvh+p2Un30+ZmuXZbtIPTgpxqHe2Ag9EteNAVay9uxIQmTg\nGb6mBo8x2cCAI+/mZtP6SwXgvnV8pK54jo6r+GPYCkUFKEXAemHg5qftCfS73+2k\nV5K3BHlbihPXxFGxiLrV0KlFF5R+ap1p2IFY+0WX6x3IzHCcxbFOBDU0j6IDEG7/\n+wIDAQAB\n-----END PUBLIC KEY-----"];
    [JSPatch sync];
}

@end
