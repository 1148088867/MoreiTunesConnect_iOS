//
//  MTCSetView.m
//  MoreiTunes
//
//  Created by Dwang on 2018/3/5.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCSetView.h"

@interface MTCSetView ()<QMUITableViewDelegate, QMUITableViewDataSource>

/** 数据源 */
psx(NSArray<NSArray<NSString *> *>, setArr);

@end

@implementation MTCSetView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.setArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.setArr[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.setArr[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    NSString *infoStr = self.setArr[indexPath.section][indexPath.row];
    if ([infoStr isEqualToString:@"关于"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MTCGitHub]];
    }
}

- (NSArray<NSArray<NSString *> *> *)setArr {
    if (!_setArr) {
        _setArr = @[@[@"关于"]];
    }
    return _setArr;
}

@end
