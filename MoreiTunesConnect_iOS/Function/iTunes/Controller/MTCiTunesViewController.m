//
//  MTCiTunesViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCiTunesViewController.h"
#import "MTCiTunesView.h"
#import "MTCSpecialModel.h"

@interface MTCiTunesViewController ()

psx(MTCiTunesView, itunesView);

@end

@implementation MTCiTunesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.subtitle = self.accountModel.mail.decryptAESString;
}

- (void)setUI {
    MTCiTunesView *itunesView = [[MTCiTunesView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    if (self.accountModel.cookiesData) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:self.accountModel.cookiesData];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookies){
            [cookieStorage setCookie:cookie];
        }
        [self iTunesConnectAppsNetworking];
    }else {
        [self iTunesConnectLoginNetworking];
    }
    itunesView.infoStr = @"没有更多数据了";
}

- (void)iTunesConnectLoginNetworking {
    [self.progressHUD showLoading:@"账号登录中..."];
    weakOBJ(self);
    [MTCNetwork postUrl:MTCiTunesLogin params:@{@"accountName":self.accountModel.mail.decryptAESString,
                 @"password":self.accountModel.password.decryptAESString,
                 @"rememberMe":@"true"} callBack:^(id success, NSError *error) {
                if ([success[@"authType"] isEqualToString:@"sa"] && !error) {
                    if (weak_self.updateCooikesData) {
                        MTCAccountModel *accountModel = weak_self.accountModel;
                        [accountModel setCookiesData:MTCCooikesData]; weak_self.updateCooikesData(accountModel);
                    }
                    [weak_self iTunesConnectAppsNetworking];
                }else {
                    [weak_self dismissProgressHUD];
                    [ISMessages showCardAlertWithTitle:@"登录失败" message:@"由于未知原因，导致登录失败，请检查信息后重新登录。" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
                    [weak_self.navigationController popViewControllerAnimated:YES];
                }
            }];
}

- (void)iTunesConnectAppsNetworking {
    [self.progressHUD showLoading:@"Apps状态查询中..."];
    weakOBJ(self);
    [MTCNetwork getUrl:MTCiTunesApps callBack:^(id success, NSError *error) {
        [weak_self dismissProgressHUD];
        if ([success[@"statusCode"] isEqualToString:@"SUCCESS"] && !error) {
            weak_self.itunesView.iTunesAppsArr = [NSArray yy_modelArrayWithClass:[MTCiTunesAppsModel class] json:success[@"data"][@"summaries"]];
            MTCSpecialModel *specialModel = [MTCSpecialModel yy_modelWithJSON:[MTCUserDefaults objectForKey:@"appinfo"]];
            if (specialModel.appid.length && [specialModel.email.decryptAESString isEqualToString:weak_self.accountModel.mail.decryptAESString]) {
                [weak_self.itunesView.iTunesAppsArr enumerateObjectsUsingBlock:^(MTCiTunesAppsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.adamId isEqualToString:specialModel.appid.decryptAESString]) {
                        NSMutableDictionary *appinfo = [specialModel yy_modelToJSONObject];
                        [appinfo setObject:MTCCooikesData forKey:@"cookiesData"];
                        [MTCUserDefaults setObject:appinfo forKey:@"appinfo"];
                    }
                }];
            }
            [weak_self.itunesView.mj_header endRefreshing];
            [weak_self.itunesView reloadData];
        }else {
            [ISMessages showCardAlertWithTitle:@"获取信息失败" message:@"由于未知原因，导致信息获取失败，请稍后再试。" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

@end

