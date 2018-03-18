//
//  MTCiTunesView.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCiTunesView.h"
#import "MTCiTunesAppsCell.h"
#import <YYWebImage.h>
#import "MTCSpecialModel.h"
#import "MTCResolutionCenterViewController.h"

@interface MTCiTunesView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation MTCiTunesView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.iTunesAppsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MTCiTunesAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MTCiTunesAppsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    MTCiTunesAppsModel *appModel = self.iTunesAppsArr[indexPath.row];
    NSArray<MTCiTunesAppVersionModel *> *appVersionModel = [NSArray yy_modelArrayWithClass:[MTCiTunesAppVersionModel class] json:appModel.versionSets];
    MTCiTunesAppInFlightVersion *appInFlightVersionModel = appVersionModel.firstObject.inFlightVersion;
    MTCiTunesAppDeliverableVersion *appDeliverableVersionModel = appVersionModel.firstObject.deliverableVersion;
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:appModel.iconUrl] options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur];
    cell.name.text = appModel.name;
    cell.lastDate.text = appModel.lastModifiedDate;
    cell.version.text = appInFlightVersionModel.version?appInFlightVersionModel.version:appDeliverableVersionModel.version;
    cell.status.backgroundColor = appInFlightVersionModel.stateColor?appInFlightVersionModel.stateColor:appDeliverableVersionModel.stateColor;
    cell.statusLab.text = appInFlightVersionModel.stateStr?appInFlightVersionModel.stateStr:appDeliverableVersionModel.stateStr;
    return cell;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTCiTunesAppsModel *appModel = self.iTunesAppsArr[indexPath.row];
    MTCSpecialModel *specialModel = [MTCSpecialModel yy_modelWithJSON:[MTCUserDefaults objectForKey:@"appinfo"]];
    if ([appModel.adamId isEqualToString:specialModel.appid.decryptAESString]) {
        UITableViewRowAction *CANCEL = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"CANCEL" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [MTCUserDefaults removeObjectForKey:@"appinfo"];
            [MTCUserDefaults synchronize];
        }];
        return @[CANCEL];
    }
    weakOBJ(appModel);
    UITableViewRowAction *SPECIAL = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"SPECIAL" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSMutableDictionary *appinfo = [NSMutableDictionary dictionary];
        [appinfo setObject:MTCCooikesData forKey:@"cookiesData"];
        [appinfo setObject:weak_appModel.adamId.encryptAESString forKey:@"appid"];
        [appinfo setObject:weak_appModel.name.encryptAESString forKey:@"appName"];
        [appinfo setObject:weak_appModel.iconUrl.encryptAESString forKey:@"appIconUrl"];
        [appinfo setObject:[NSDate dateCurrentTimeWithFormat:MTCTimeFormat] forKey:@"SPECIALTime"];
        [MTCUserDefaults setObject:appinfo forKey:@"appinfo"];
        [MTCUserDefaults synchronize];
    }];
    
    return @[SPECIAL];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    MTCiTunesAppsModel *appModel = self.iTunesAppsArr[indexPath.row];
    MTCResolutionCenterViewController *resolutionCenter = [[MTCResolutionCenterViewController alloc] init];
    resolutionCenter.title = appModel.name;
    resolutionCenter.titleView.subtitle = appModel.adamId;
    resolutionCenter.appid = appModel.adamId;
    [self.viewController.navigationController pushViewController:resolutionCenter animated:YES];
}

- (NSArray *)iTunesAppsArr {
    if (!_iTunesAppsArr) {
        _iTunesAppsArr = [NSArray array];
    }
    return _iTunesAppsArr;
}

@end
