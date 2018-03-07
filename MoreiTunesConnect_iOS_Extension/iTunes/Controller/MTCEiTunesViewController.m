//
//  TodayViewController.m
//  MoreiTunesConnect_iOS_Extension
//
//  Created by Dwang on 2018/3/7.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCEiTunesViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "MTCSpecialModel.h"
#import <YYWebImage.h>
#import "MTCiTunesAppsModel.h"
#import "MTCEiTunesView.h"

@interface MTCEiTunesViewController () <NCWidgetProviding>

psx(MTCEiTunesView, iTunesView);

@end

@implementation MTCEiTunesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MTCSpecialModel *specialModel = [MTCSpecialModel yy_modelWithJSON:[MTCUserDefaults objectForKey:@"appinfo"]];
    if (specialModel.appid.length) {
        [self loadAppViewWith:specialModel];
    }else {
        UILabel *noData = [[UILabel alloc] init];
        noData.text = @"暂未发现数据";
        noData.textColor = UIColorHex(#838079);
        noData.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:noData];
        [noData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (void)loadAppViewWith:(MTCSpecialModel *)specialModel {

    if(specialModel.cookiesData) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:specialModel.cookiesData];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookies){
            [cookieStorage setCookie:cookie];
        }
    }
    
    MTCEiTunesView *iTunesView = [[MTCEiTunesView alloc] init];
    selfClass(iTunesView);
    [self.view addSubview:iTunesView];
    [iTunesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [iTunesView.icon yy_setImageWithURL:[NSURL URLWithString:specialModel.appIconUrl.decryptAESString] options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionShowNetworkActivity|YYWebImageOptionUseNSURLCache];
    iTunesView.name.text = specialModel.appName.decryptAESString;
    
    [self iTunesConnectAppsNetworking:specialModel];
}

- (void)iTunesConnectAppsNetworking:(MTCSpecialModel *)specialModel {
    weakOBJ(self);
    [MTCNetwork getUrl:MTCiTunesApps callBack:^(id success, NSError *error) {
        if ([success[@"statusCode"] isEqualToString:@"SUCCESS"] && !error) {
            NSArray<MTCiTunesAppsModel *> *iTunesAppsArr = [NSArray yy_modelArrayWithClass:[MTCiTunesAppsModel class] json:success[@"data"][@"summaries"]];
            [iTunesAppsArr enumerateObjectsUsingBlock:^(MTCiTunesAppsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.adamId isEqualToString:specialModel.appid.decryptAESString]) {
                    NSArray<MTCiTunesAppVersionModel *> *appVersionModel = [NSArray yy_modelArrayWithClass:[MTCiTunesAppVersionModel class] json:obj.versionSets];
                    MTCiTunesAppInFlightVersion *appInFlightVersionModel = appVersionModel.firstObject.inFlightVersion;
                    [weak_self.iTunesView.icon yy_setImageWithURL:[NSURL URLWithString:obj.iconUrl] options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionShowNetworkActivity|YYWebImageOptionUseNSURLCache];
                    weak_self.iTunesView.name.text = obj.name;
                    weak_self.iTunesView.lastDate.text = obj.lastModifiedDate;
                    weak_self.iTunesView.version.text = appInFlightVersionModel.version;
                    weak_self.iTunesView.status.backgroundColor = appInFlightVersionModel.stateColor;
                    weak_self.iTunesView.statusLab.text = appInFlightVersionModel.stateStr;
                    *stop = YES;
                }
            }];
        }else {
            [weak_self iTunesConnectLoginNetworking:specialModel];
        }
    }];
}

- (void)iTunesConnectLoginNetworking:(MTCSpecialModel *)specialModel {
    weakOBJ(self);
    [MTCNetwork postUrl:MTCiTunesLogin params:@{@"accountName":specialModel.email.decryptAESString,
                                                @"password":specialModel.password.decryptAESString,
                                                @"rememberMe":@"true"} callBack:^(id success, NSError *error) {
                                                    if ([success[@"authType"] isEqualToString:@"sa"] && !error) {
                                                        [weak_self iTunesConnectAppsNetworking:specialModel];
                                                    }
                                                }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (@available(iOS 10.0, *)) {
//        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
//    }else {
//        [self.extensionContext setValue:@"1" forKey:@"widgetLargestAvailableDisplayMode"];
//    }
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize NS_AVAILABLE_IOS(10_0) {
        if (activeDisplayMode == 0) {
            self.preferredContentSize = CGSizeMake(YYScreenSize().width, 110);
        } else {
            self.preferredContentSize = CGSizeMake(YYScreenSize().width, 200);
        }
}


- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
}

@end
