//
//  DTAppsViewController.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTAppsViewController.h"
#import "DTAppsView.h"
#import "DTAppsStatusModel.h"

@interface DTAppsViewController ()

@end

@implementation DTAppsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Apps Status";
}

- (void)setUI {
    DTAppsView *appsView = [[DTAppsView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    appsView.appsArr = [NSArray yy_modelArrayWithClass:[DTAppsStatusModel class] json:self.appsArr];
    [self.baseView addSubview:appsView];
    [appsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.right.left.bottom.equalTo(self.view);
    }];
}

@end
