//
//  MTiTunesViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTiTunesViewController.h"
#import "MTiTunesView.h"

@interface MTiTunesViewController ()

psx(MTiTunesView, itunesView);

@end

@implementation MTiTunesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    MTiTunesView *itunesView = [[MTiTunesView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(itunesView);
    [self.baseView addSubview:itunesView];
    [itunesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    weakOBJ(self);
    itunesView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self iTunesConnectAppsNetworking];
    }];
    itunesView.mj_header.automaticallyChangeAlpha = YES;
    [self iTunesConnectLoginNetworking];
    
}

- (void)iTunesConnectLoginNetworking {
    self.progressHUD.detailsLabel.text = @"账号登录中...";
    [self.progressHUD showAnimated:YES];
    weakOBJ(self);
    [DWNetworking postUrlString:MTiTunesLogin params:@{@"accountName":self.accountModel.mail.decryptAESString,
                                                       @"password":self.accountModel.password.decryptAESString,
                                                       @"rememberMe":@"true"} resultCallBack:^(id success, NSError *error, BOOL isCache) {
                                                           if ([success[@"authType"] isEqualToString:@"sa"] && !error) {
                                                               weak_self.progressHUD.detailsLabel.text = @"Apps状态查询中";
                                                               [weak_self iTunesConnectAppsNetworking];
                                                           }else {
                                                               [weak_self dismissProgressHUD];
                                                               [ISMessages showCardAlertWithTitle:@"登录失败" message:@"由于未知原因，导致登录失败，请检查信息后重新登录。" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                                                               [weak_self.navigationController popViewControllerAnimated:YES];
                                                           }
                                                       }];
}

- (void)iTunesConnectAppsNetworking {
    weakOBJ(self);
    [DWNetworking getUrlString:MTiTunesApps params:nil resultCallBack:^(id success, NSError *error, BOOL isCache) {
        [weak_self dismissProgressHUD];
        if ([success[@"statusCode"] isEqualToString:@"SUCCESS"] && !error) {
            weak_self.itunesView.iTunesAppsArr = [NSArray yy_modelArrayWithClass:[MTiTunesAppsModel class] json:success[@"data"][@"summaries"]];
            [weak_self.itunesView.mj_header endRefreshing];
            [weak_self.itunesView reloadData];
        }else {
            [ISMessages showCardAlertWithTitle:@"获取信息失败" message:@"由于未知原因，导致信息获取失败，请稍后再试。" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

@end
