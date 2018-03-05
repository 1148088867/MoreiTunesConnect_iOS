//
//  MTBaseViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTBaseViewController.h"
#import <IQKeyboardManager.h>
#import <JPFPSStatus.h>
#import "MTBaseNavigationController.h"

@interface MTBaseViewController ()

@end

@implementation MTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.subtitle = @"CoderDwang";
    self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    if (IS_DEBUG) {
        [[JPFPSStatus sharedInstance] open];
    }
}

- (void)dealloc {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if( self.view.window == nil && [self isViewLoaded]) {
        self.view = nil;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
    self.progressHUD = nil;
}

@end
