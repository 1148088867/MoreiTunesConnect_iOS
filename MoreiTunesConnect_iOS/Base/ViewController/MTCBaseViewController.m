//
//  MTCBaseViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCBaseViewController.h"
#import <IQKeyboardManager.h>
#import <JPFPSStatus.h>
#import "MTCBaseNavigationController.h"
#import <DWNetworking.h>

@interface MTCBaseViewController ()

@end

@implementation MTCBaseViewController

- (void)didInitialized {
    [super didInitialized];
    self.titleView.subtitle = @"CoderDwang";
    self.titleView.verticalSubtitleFont = UIFontMakeNameWithSize(@"AmericanTypewriter", 12);
    self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    if (IS_DEBUG) {
        [[JPFPSStatus sharedInstance] open];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [DWNetworking cancelAllTask];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [DWNetworking cancelAllTask];
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

@end
