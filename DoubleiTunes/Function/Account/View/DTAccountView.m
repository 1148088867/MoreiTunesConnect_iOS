//
//  DTAccountView.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/18.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTAccountView.h"
#import "DTAccountCell.h"
#import "DTCreateAccountViewController.h"
#import "DTiTunesViewController.h"

@interface DTAccountView ()<QMUITableViewDelegate, QMUITableViewDataSource>

@end

@implementation DTAccountView

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
    DTAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DTAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    DTAccountModel *model = self.accountModelArrM[indexPath.row];
    cell.mail.text = [NSString stringWithFormat:@"Apple id: %@", model.mail.decryptAESString];
    cell.note.text = [NSString stringWithFormat:@"备注: %@", model.note.decryptAESString];
    cell.addTime.text = model.addTime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    DTiTunesViewController *iTunes = [[DTiTunesViewController alloc] init];
    iTunes.accountModel = self.accountModelArrM[indexPath.row];
    [self.viewController.navigationController pushViewController:iTunes animated:YES];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    weakOBJ(self);
    UITableViewRowAction *editor = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        DTCreateAccountViewController *createAccount = [[DTCreateAccountViewController alloc] init];
        createAccount.accountModel = weak_self.accountModelArrM[indexPath.row];
        createAccount.title = @"ChangeAccount";
        [weak_self.viewController.navigationController pushViewController:createAccount animated:YES];
        createAccount.createAccountSuccess = ^(DTAccountModel *accountModel) {
            [weak_self.accountModelArrM removeObjectAtIndex:indexPath.row];
            [weak_self.accountModelArrM insertObject:accountModel atIndex:0];
            [weak_self reloadData];
        };
    }];
    UITableViewRowAction *remove = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        YTKKeyValueItem *item = DTSQL.keyValueItems[self.accountModelArrM.count-(indexPath.row+1)];
        [DTSQL.store deleteObjectById:item.itemId fromTable:DTAccountTableName];
        [weak_self.accountModelArrM removeObjectAtIndex:indexPath.row];
        if (weak_self.accountModelArrM.count) {
            [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
        }else {
            [tableView reloadData];
        }
    }];
    return @[remove, editor];
}

- (NSMutableArray<DTAccountModel *> *)accountModelArrM {
    if (!_accountModelArrM) {
        _accountModelArrM = [NSMutableArray array];
        [DTSQL.keyValueItems enumerateObjectsUsingBlock:^(YTKKeyValueItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_accountModelArrM insertObject:[DTAccountModel yy_modelWithJSON:obj.itemObject] atIndex:0];
        }];
    }
    return _accountModelArrM;
}



@end
