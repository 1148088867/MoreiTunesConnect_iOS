//
//  UIViewController+DWExtension.m
//  test
//
//  Created by Dwang on 2018/1/24.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UIViewController+DWExtension.h"
#import <objc/runtime.h>
#import "UINavigationController+DWExtension.h"

static const char *DWBaseViewKey = "dw_baseViewKey";
static BOOL _dwNavigationBarTransparent = NO;
static BOOL _dwHasBaseView = YES;

@interface UIViewController ()<UIGestureRecognizerDelegate>

@end

@implementation UIViewController (DWExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sys_Method = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method dw_Method = class_getInstanceMethod(self, @selector(dw_viewDidLoad));
        method_exchangeImplementations(sys_Method, dw_Method);
    });
}

- (void)dw_viewDidLoad {
    [self dw_viewDidLoad];
    UINavigationController *navController = (UINavigationController *)self.navigationController;
    if ([navController screenEdgePanGestureRecognizer]) {
        [self.baseView.panGestureRecognizer requireGestureRecognizerToFail:[navController screenEdgePanGestureRecognizer]];
    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.baseView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.baseView.backgroundColor = self.view.backgroundColor;
    self.baseView.showsHorizontalScrollIndicator = NO;
    self.baseView.showsVerticalScrollIndicator = NO;
    self.baseView.alwaysBounceVertical = YES;
    self.baseView.scrollEnabled = NO;
    [self.view addSubview:self.baseView];
    [self.view sendSubviewToBack:self.baseView];
    [self setUI];
}

- (void)setUI {
}

- (void)setBaseView:(UIScrollView *)baseView {
    objc_setAssociatedObject(UIScrollView.class, DWBaseViewKey, baseView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollView *)baseView {
    return objc_getAssociatedObject(UIScrollView.class, DWBaseViewKey);
}

- (void)setNavigationBarTransparent:(BOOL)navigationBarTransparent {
    _dwNavigationBarTransparent  = navigationBarTransparent;
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:navigationBarTransparent?[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Resources.bundle/navigationBartransparent"]]:nil forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)isNavigationBarTransparent {
    return _dwNavigationBarTransparent;
}

- (void)setHasBaseView:(BOOL)hasBaseView {
    _dwHasBaseView = hasBaseView;
    if (!hasBaseView) {
        [self.baseView removeFromSuperview];
    }
}

- (BOOL)isHasBaseView {
    return _dwHasBaseView;
}

@end

