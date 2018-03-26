//
//  MTCBaseNavigationController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCBaseNavigationController.h"

@interface MTCBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MTCBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    //暂时抛弃全屏返回手势，因为和cell的滑动事件有冲突
//    [self setupSlideGesture];
}

- (void)setupSlideGesture {
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

@end

