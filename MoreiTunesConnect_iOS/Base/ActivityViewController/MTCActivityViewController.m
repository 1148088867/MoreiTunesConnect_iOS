//
//  MTCActivityViewController.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCActivityViewController.h"

@interface MTCActivityViewController ()

@end

@implementation MTCActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实测中发现，当执行viewDidLoad之后ActivityViewController视图才出现，所以在viewDidLoad中将HUD取消才是最佳时机
    if (self.dismissHUD) {
        self.dismissHUD();
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
