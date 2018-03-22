//
//  MTCResolutionCenterViewController.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/16.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCResolutionCenterViewController.h"
#import "MTCResolutionCenterView.h"
#import "MTCKPViewController.h"

@interface MTCResolutionCenterViewController ()

psx(MTCResolutionCenterView, resolutionCenter);

@end

@implementation MTCResolutionCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUI {
    MTCResolutionCenterView *resolutionCenter = [[MTCResolutionCenterView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(resolutionCenter);
    [self.baseView addSubview:resolutionCenter];
    [resolutionCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    weakOBJ(self);
    resolutionCenter.kpViewController = ^(NSString *versionid) {
        MTCKPViewController *kp = [[MTCKPViewController alloc] init];
        kp.title = weak_self.title;
        kp.titleView.subtitle = versionid;
        kp.appid = weak_self.titleView.subtitle;
        kp.versionid = versionid;
        [weak_self.navigationController pushViewController:kp animated:YES];
    };
    [self resolutionCenterNetworking];
}

- (void)resolutionCenterNetworking {
    weakOBJ(self);
    [self.progressHUD showLoading:@"正在获取回执信息..."];
    [MTCNetwork getUrl:MTCiTunesResolutionCenter(self.appid) callBack:^(id success, NSError *error) {
        [weak_self dismissProgressHUD];
        if (!error && [success[@"statusCode"] isEqualToString:@"SUCCESS"]) {
            weak_self.resolutionCenter.resolutionCenterArr = [NSArray yy_modelArrayWithClass:[MTCResolutionCenterModel class] json:success[@"data"][@"appNotes"][@"threads"]];
            [weak_self.resolutionCenter reloadData];
        }else {
            
        }
    }];
}

@end
