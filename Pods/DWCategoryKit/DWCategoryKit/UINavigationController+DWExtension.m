//
//  UINavigationController+DWExtension.m
//  test
//
//  Created by Dwang on 2018/1/31.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UINavigationController+DWExtension.h"
#import <objc/runtime.h>

@implementation UINavigationController (DWExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method sys_Method = class_getInstanceMethod(self, @selector(pushViewController:animated:));
        Method dw_Method = class_getInstanceMethod(self, @selector(dw_pushViewController:animated:));
        method_exchangeImplementations(sys_Method, dw_Method);
    });
}

- (void)dw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [self dw_pushViewController:viewController animated:animated];
}

- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer {
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.view.gestureRecognizers.count > 0) {
        for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}

@end
