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

@end

@implementation MTiTunesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    NSLog(@"%@---%@", self.accountModel.mail.decryptAESString, self.accountModel.password.decryptAESString);
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
                     }
    }];
}

- (void)iTunesConnectAppsNetworking {
    weakOBJ(self);
    [DWNetworking getUrlString:MTiTunesApps params:nil resultCallBack:^(id success, NSError *error, BOOL isCache) {
        [weak_self dismissProgressHUD];
        if ([success[@"statusCode"] isEqualToString:@"SUCCESS"] && !error) {
            
        }else {
            [ISMessages showCardAlertWithTitle:@"获取信息失败" message:@"由于未知原因，导致信息获取失败，请稍后再试。" duration:2.25 hideOnSwipe:NO hideOnTap:NO alertType:ISAlertTypeError alertPosition:ISAlertPositionTop didHide:nil];
        }
    }];
}

@end
