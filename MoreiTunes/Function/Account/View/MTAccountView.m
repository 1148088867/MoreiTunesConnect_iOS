//
//  MTAccountView.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTAccountView.h"
#import "MTAccountCell.h"
#import "MTCreateAccountViewController.h"
#import "MTiTunesViewController.h"

@interface MTAccountView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation MTAccountView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accountModelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MTAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MTAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    MTAccountModel *model = self.accountModelArrM[indexPath.row];
    cell.mail.text = [NSString stringWithFormat:@"Apple id: %@", model.mail.decryptAESString];
    cell.note.text = [NSString stringWithFormat:@"备注: %@", model.note.decryptAESString];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    MTiTunesViewController *iTunesViewController = [[MTiTunesViewController alloc] init];
    iTunesViewController.title = @"iTunes Connect";
    iTunesViewController.accountModel = self.accountModelArrM[indexPath.row];
    [self.viewController.navigationController pushViewController:iTunesViewController animated:YES];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    weakOBJ(self);
    UITableViewRowAction *editor = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        MTCreateAccountViewController *createAccount = [[MTCreateAccountViewController alloc] init];
        createAccount.accountModel = weak_self.accountModelArrM[indexPath.row];
        createAccount.title = @"ChangeAccount";
        [weak_self.viewController.navigationController pushViewController:createAccount animated:YES];
        createAccount.createAccountSuccess = ^(MTAccountModel *accountModel) {
            [weak_self.accountModelArrM removeObjectAtIndex:indexPath.row];
            [weak_self.accountModelArrM insertObject:accountModel atIndex:0];
            [weak_self reloadData];
        };
    }];
    UITableViewRowAction *remove = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        YTKKeyValueItem *item = MTSQL.keyValueItems[self.accountModelArrM.count-(indexPath.row+1)];
        [MTSQL.store deleteObjectById:item.itemId fromTable:MTAccountTableName];
        [weak_self.accountModelArrM removeObjectAtIndex:indexPath.row];
        if (weak_self.accountModelArrM.count) {
            [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
        }else {
            [tableView reloadData];
        }
    }];
    return @[remove, editor];
}

- (NSMutableArray<MTAccountModel *> *)accountModelArrM {
    if (!_accountModelArrM) {
        _accountModelArrM = [NSMutableArray array];
        UIPasteboard *paste = [UIPasteboard generalPasteboard];
        if ([paste.string hasPrefix:@"{"] && [paste.string hasSuffix:@"}"]) {
            NSArray <NSString *>*accounts = [[[[[[[paste.string stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@"\r" withString:@""] stringByReplacingOccurrencesOfString:@"\t" withString:@""] componentsSeparatedByString:@">"];
            [accounts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray <NSString *>*infoStr = [obj componentsSeparatedByString:@"/"];
                if (infoStr.count < 2 ||
                    !infoStr.firstObject.length ||
                    !infoStr[1].length) {
                    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"添加失败" message:[NSString stringWithFormat:@"<%@>添加失败", infoStr.firstObject] preferredStyle:QMUIAlertControllerStyleAlert];
                    [alert addAction:[QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {}]];
                    [alert showWithAnimated:YES];
                    return ;
                }
                NSString *key = [NSString stringWithFormat:@"%@%@", [NSDate dateCurrentTimeWithFormat:@"YYYY-MM-dd HH:mm:ss"], [NSString repeat:idx]];
                MTAccountModel *accountModel = [[MTAccountModel alloc] init];
                accountModel.mail = infoStr.firstObject.encryptAESString;
                accountModel.password = infoStr[1].encryptAESString;
                accountModel.adMTime = [NSDate dateCurrentTimeWithFormat:@"YYYY-MM-dd HH:mm:ss"];
                if (infoStr.count == 3 && infoStr.lastObject.length) {
                    accountModel.note = infoStr.lastObject.encryptAESString;
                }else {
                    accountModel.note = key.encryptAESString;
                }
                [MTSQL.store putObject:accountModel.yy_modelToJSONObject withId:key intoTable:MTAccountTableName];
                paste.string = @"";
            }];
        }
        [MTSQL.keyValueItems enumerateObjectsUsingBlock:^(YTKKeyValueItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_accountModelArrM insertObject:[MTAccountModel yy_modelWithJSON:obj.itemObject] atIndex:0];
        }];
    }
    return _accountModelArrM;
}

@end
