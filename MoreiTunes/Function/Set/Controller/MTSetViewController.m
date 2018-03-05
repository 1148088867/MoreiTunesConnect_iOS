//
//  MTSetViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/5.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTSetViewController.h"
#import "MTSetView.h"

@interface MTSetViewController ()

@end

@implementation MTSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    MTSetView *setView = [[MTSetView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.baseView addSubview:setView];
    [setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    setView.infoStr = @"MoreiTunes由CoderDwang 制作";
}

@end
