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
    cell.userInteractionEnabled = NO;
    MTCiTunesAppsModel *appModel = self.iTunesAppsArr[indexPath.row];
    NSArray<MTCiTunesAppVersionModel *> *appVersionModel = [NSArray yy_modelArrayWithClass:[MTCiTunesAppVersionModel class] json:appModel.versionSets];
    MTCiTunesAppInFlightVersion *appInFlightVersionModel = appVersionModel.firstObject.inFlightVersion;
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:appModel.iconUrl] options:YYWebImageOptionProgressive|YYWebImageOptionProgressiveBlur|YYWebImageOptionShowNetworkActivity|YYWebImageOptionUseNSURLCache];
    cell.name.text = appModel.name;
    cell.lastDate.text = appModel.lastModifiedDate;
    cell.version.text = appInFlightVersionModel.version;
    cell.status.backgroundColor = appInFlightVersionModel.stateColor;
    cell.statusLab.text = appInFlightVersionModel.stateStr;
//    cell.statusLab.textColor = appInFlightVersionModel.stateColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (NSArray *)iTunesAppsArr {
    if (!_iTunesAppsArr) {
        _iTunesAppsArr = [NSArray array];
    }
    return _iTunesAppsArr;
}

@end
