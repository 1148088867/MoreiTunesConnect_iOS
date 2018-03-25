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
    [self setupSlideGesture];
}

- (void)setupSlideGesture {
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc]init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    id gestureRecognizerTarget = [_targets firstObject];
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //使用了私有属性
    return self.viewControllers.count !=1 &&
    ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end

