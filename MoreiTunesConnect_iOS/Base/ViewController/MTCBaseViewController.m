//
//  MTCBaseViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCBaseViewController.h"
#import "MTCBaseNavigationController.h"
#import <Social/Social.h>
#import <DWNetworking.h>
#import <JPFPSStatus.h>
#import "MTCActivityViewController.h"

@interface MTCBaseViewController ()

@end

@implementation MTCBaseViewController

- (void)didInitialized {
    [super didInitialized];
    if (IS_DEBUG)[self JPFPSConfig];
    self.titleView.subtitle = @"CoderDwang";
    self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
    self.titleView.verticalSubtitleFont = UIFontMakeNameWithSize(@"AmericanTypewriter", 12);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)JPFPSConfig {
    [[JPFPSStatus sharedInstance] open];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if( self.view.window == nil && [self isViewLoaded]) {
        self.view = nil;
    }
}

- (QMUITips *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [[QMUITips alloc] initWithView:self.view];
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
}

- (void)dismissProgressHUD {
    [self.progressHUD hideAnimated:YES];
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}

- (void)showActivityViewControllerWithItems:(NSArray *)activityItems obj:(id)obj{
    [[obj progressHUD] showLoading:@"请稍候..."];
    MTCActivityViewController *activityViewController = [[MTCActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.dismissHUD = ^{
        [obj dismissProgressHUD];
    };
    [obj presentViewController:activityViewController animated:YES completion:nil];
}

- (void)dealloc {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [DWNetworking cancelAllTask];
}

@end
