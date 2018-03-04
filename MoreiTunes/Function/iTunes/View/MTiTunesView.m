//
//  MTiTunesView.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/4.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTiTunesView.h"
#import "MTiTunesAppsCell.h"
#import <YYWebImage.h>

@interface MTiTunesView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation MTiTunesView

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
    MTiTunesAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MTiTunesAppsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.userInteractionEnabled = NO;
    MTiTunesAppsModel *appModel = self.iTunesAppsArr[indexPath.row];
    NSArray<MTiTunesAppVersionModel *> *appVersionModel = [NSArray yy_modelArrayWithClass:[MTiTunesAppVersionModel class] json:appModel.versionSets];
    MTiTunesAppInFlightVersion *appInFlightVersionModel = appVersionModel.firstObject.inFlightVersion;
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
