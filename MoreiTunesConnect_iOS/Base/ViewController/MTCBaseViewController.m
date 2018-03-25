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
#import "MTCActivityViewController.h"

@interface MTCBaseViewController ()

@end

@implementation MTCBaseViewController

- (void)didInitialized {
    [super didInitialized];
    self.titleView.subtitle = @"CoderDwang";
    self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
    self.titleView.verticalSubtitleFont = UIFontMakeNameWithSize(@"AmericanTypewriter", 12);
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self showActivityViewControllerWithItems:@[[self.view qmui_snapshotLayerImage]] obj:self];
    }
}

- (void)setAnimatedWithTransitionType:(NSString *)type {
    CATransition *animation = [CATransition animation];
    animation.duration = 1.25f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [animation setType:type];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
}

- (void)dealloc {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [DWNetworking cancelAllTask];
}

@end
