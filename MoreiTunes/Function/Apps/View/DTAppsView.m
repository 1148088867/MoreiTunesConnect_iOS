//
//  DTAppsView.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTAppsView.h"
#import "DTAppsStatusModel.h"
#import "DTAppsCell.h"
#import <YYWebImage.h>

@interface DTAppsView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation DTAppsView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    DTAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DTAppsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.userInteractionEnabled = NO;
    DTAppsStatusModel *model = self.appsArr[indexPath.row];
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:model.appIcon] options:YYWebImageOptionProgressive];
    cell.name.text = model.appName;
    cell.status.text = model.appStatus;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}

- (NSArray<DTAppsStatusModel *> *)appsArr {
    if (!_appsArr) {
        _appsArr = [NSArray array];
    }
    return _appsArr;
}

@end
