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

psx(MTCSpecialModel, specialModel);

psx(MTCEiTunesView, iTunesView);

psx(UIActivityIndicatorView, activity);

@end

@implementation MTCEiTunesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.specialModel.appid.length) {
        [self loadAppView];
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

- (void)loadAppView {
    
    if(self.specialModel.cookiesData) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:self.specialModel.cookiesData];
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
    [iTunesView.icon yy_setImageWithURL:[NSURL URLWithString:self.specialModel.appIconUrl.decryptAESString] options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur];
//    iTunesView.name.text = specialModel.appName.decryptAESString;
    
    [self iTunesConnectAppsNetworking];
    weakOBJ(self);
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weak_self iTunesConnectAppsNetworking];
    }]];
}

- (void)iTunesConnectAppsNetworking {
    if (!self.activity.isAnimating) {
        [self.activity startAnimating];
    }
    weakOBJ(self);
    [MTCNetwork getUrl:MTCiTunesApps callBack:^(id success, NSError *error) {
        if ([success[@"statusCode"] isEqualToString:@"SUCCESS"] && !error) {
            NSArray<MTCiTunesAppsModel *> *iTunesAppsArr = [NSArray yy_modelArrayWithClass:[MTCiTunesAppsModel class] json:success[@"data"][@"summaries"]];
            [iTunesAppsArr enumerateObjectsUsingBlock:^(MTCiTunesAppsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.adamId isEqualToString:weak_self.specialModel.appid.decryptAESString]) {
                    [weak_self stopAnimating];
                    NSArray<MTCiTunesAppVersionModel *> *appVersionModel = [NSArray yy_modelArrayWithClass:[MTCiTunesAppVersionModel class] json:obj.versionSets];
                    MTCiTunesAppInFlightVersion *appInFlightVersionModel = appVersionModel.firstObject.inFlightVersion;
                    [weak_self.iTunesView.icon yy_setImageWithURL:[NSURL URLWithString:obj.iconUrl] options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur];
                    weak_self.iTunesView.name.text = obj.name;
                    weak_self.iTunesView.lastDate.text = obj.lastModifiedDate;
                    weak_self.iTunesView.version.text = appInFlightVersionModel.version;
                    weak_self.iTunesView.status.backgroundColor = appInFlightVersionModel.stateColor;
                    weak_self.iTunesView.statusLab.text = appInFlightVersionModel.stateStr;
                    *stop = YES;
                }
            }];
        }else {
            [weak_self iTunesConnectLoginNetworking];
        }
    }];
}

- (void)iTunesConnectLoginNetworking {
    weakOBJ(self);
    [MTCNetwork postUrl:MTCiTunesLogin params:@{@"accountName":self.specialModel.email.decryptAESString,
                                                @"password":self.specialModel.password.decryptAESString,
                                                @"rememberMe":@"true"} callBack:^(id success, NSError *error) {
                                                    if ([success[@"authType"] isEqualToString:@"sa"] && !error) {
                                                        NSMutableDictionary *appinfo = [self.specialModel yy_modelToJSONObject];
                                                        [appinfo setObject:MTCCooikesData forKey:@"cookiesData"];
                                                        [MTCUserDefaults setObject:appinfo forKey:@"appinfo"];
                                                        [weak_self iTunesConnectAppsNetworking];
                                                    }else {
                                                        weak_self.iTunesView.name.text = @"登录失败,请前往App内检查。";
                                                        weak_self.iTunesView.name.textColor = [UIColor redColor];
                                                        [weak_self stopAnimating];
                                                    }
                                                }];
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

- (MTCSpecialModel *)specialModel {
    if (!_specialModel) {
        _specialModel = [MTCSpecialModel yy_modelWithJSON:[MTCUserDefaults objectForKey:@"appinfo"]];
    }
    return _specialModel;
}

- (UIActivityIndicatorView *)activity {
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.view addSubview:_activity];
        [_activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    return _activity;
}

- (void)stopAnimating {
    [self.activity stopAnimating];
    [self.activity setHidesWhenStopped:YES];
    self.activity = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    if (@available(iOS 10.0, *)) {
    //        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    //    }else {
    //        [self.extensionContext setValue:@"1" forKey:@"widgetLargestAvailableDisplayMode"];
    //    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopAnimating];
}

@end

