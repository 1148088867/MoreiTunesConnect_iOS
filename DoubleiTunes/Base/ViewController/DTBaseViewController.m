//
//  DTBaseViewController.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTBaseViewController.h"
#import <IQKeyboardManager.h>
#import <JPFPSStatus.h>
#import "DTBaseNavigationController.h"

@interface DTBaseViewController ()

@end

@implementation DTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    if (IS_DEBUG) {
        [[JPFPSStatus sharedInstance] open];
    }
    DTBaseNavigationController *navController = (DTBaseNavigationController *)self.navigationController;
    if ([navController screenEdgePanGestureRecognizer]) {
        [self.baseView.panGestureRecognizer requireGestureRecognizerToFail:[navController screenEdgePanGestureRecognizer]];
    }
}

- (void)setUI {
    
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

- (UIScrollView *)baseView {
    if (!_baseView) {
        _baseView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _baseView.backgroundColor = self.view.backgroundColor;
        _baseView.showsHorizontalScrollIndicator = NO;
        _baseView.showsVerticalScrollIndicator = NO;
        _baseView.alwaysBounceVertical = YES;
        _baseView.scrollEnabled = NO;
        [self.view addSubview:self.baseView];
        [self.view sendSubviewToBack:_baseView];
    }
    return _baseView;
}

- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _progressHUD;
}

- (void)dismissProgressHUD {
    [self.progressHUD hideAnimated:YES];
    self.progressHUD = nil;
}

- (void)setNavigationBarTransparence {
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
}

@end
