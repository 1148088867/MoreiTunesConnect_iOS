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
#import "MTCStatusViewController.h"

@interface MTCiTunesView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation MTCiTunesView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
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
    NSArray<MTCiTunesAppVersionSetsModel *> *appVersionSetsModel = [NSArray yy_modelArrayWithClass:[MTCiTunesAppVersionSetsModel class] json:appModel.versionSets];
    MTCiTunesAppVersionModel *appInFlightVersionModel = appVersionSetsModel.firstObject.inFlightVersion;
    MTCiTunesAppVersionModel *appDeliverableVersionModel = appVersionSetsModel.firstObject.deliverableVersion;
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:appModel.iconUrl] options:YYWebImageOptionProgressive];
    cell.name.text = appModel.name;
    cell.lastDate.text = appModel.lastModifiedDate;
    cell.version.text = appInFlightVersionModel.version?appInFlightVersionModel.version:appDeliverableVersionModel.version;
    cell.status.backgroundColor = appInFlightVersionModel.stateColor?appInFlightVersionModel.stateColor:appDeliverableVersionModel.stateColor;
    cell.statusLab.text = appInFlightVersionModel.stateStr?appInFlightVersionModel.stateStr:appDeliverableVersionModel.stateStr;
    return cell;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    weakOBJ(self);
    UITableViewRowAction *notFocus = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"NotFocus" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        MTCiTunesAppsModel *appModel = weak_self.iTunesAppsArr[indexPath.row];
        NSMutableDictionary *appINFO = [NSMutableDictionary dictionary];
        [appINFO setObject:appModel.adamId.encryptAESString forKey:@"appid"];
        [appINFO setObject:MTCBaseController(weak_self).titleView.subtitle forKey:@"attribution"];
        [appINFO setObject:appModel.iconUrl forKey:@"appIconUrl"];
        [appINFO setObject:appModel.name forKey:@"appName"];
        [appINFO setObject:MTCTime forKey:@"nfTime"];
        [MTCSQL.nfStore putObject:appINFO withId:appINFO[@"nfTime"] intoTable:MTCNOTFOCUSTABLENAME];
        [weak_self.iTunesAppsArr removeObjectAtIndex:indexPath.row];
        if (weak_self.iTunesAppsArr.count) {
            [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
        }else {
            [tableView reloadData];
        }
    }];
    return @[notFocus];
}

/*
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
 [appinfo setObject:MTCTime forKey:@"SPECIALTime"];
 [MTCUserDefaults setObject:appinfo forKey:@"appinfo"];
 [MTCUserDefaults synchronize];
 }];
 
 return @[SPECIAL];
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    MTCiTunesAppsModel *appModel = self.iTunesAppsArr[indexPath.row];
    MTCStatusViewController *status = [[MTCStatusViewController alloc] init];
    status.appid = appModel.adamId;
    status.title = appModel.name;
    status.titleView.subtitle = appModel.bundleId;
    [self.viewController.navigationController pushViewController:status animated:YES];
}

- (NSMutableArray *)iTunesAppsArr {
    if (!_iTunesAppsArr) {
        _iTunesAppsArr = [NSMutableArray array];
    }
    return _iTunesAppsArr;
}

@end

