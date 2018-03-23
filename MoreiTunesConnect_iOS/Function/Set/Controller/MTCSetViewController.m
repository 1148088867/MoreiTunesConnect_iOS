//
//  MTCSetViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/5.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCSetViewController.h"
#import "MTCSetView.h"

@interface MTCSetViewController ()

@end

@implementation MTCSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    MTCSetView *setView = [[MTCSetView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.baseView addSubview:setView];
    [setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    setView.infoStr = [NSString stringWithFormat:@"Current Version %@\nMoreiTunesConnect_iOS由CoderDwang 制作", [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
}

@end
