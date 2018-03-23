//
//  MTCNotFocusView.m
//  MoreiTunesConnect_iOS
//
//  Created by Dwang on 2018/3/23.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCNotFocusView.h"
#import "MTCNotFocusModel.h"
#import "MTCNotFocusCell.h"
#import <YYWebImage.h>

@interface MTCNotFocusView ()<QMUITableViewDelegate, QMUITableViewDataSource>

psx(NSMutableArray<MTCNotFocusModel *>, notFocusModelArrM);

@end

@implementation MTCNotFocusView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notFocusModelArrM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MTCNotFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MTCNotFocusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MTCNotFocusModel *nfModel = self.notFocusModelArrM[indexPath.row];
    [cell.icon yy_setImageWithURL:[NSURL URLWithString:nfModel.appIconUrl] options:YYWebImageOptionProgressive];
    cell.name.text = nfModel.appName;
    cell.hiddenTime.text = nfModel.nfTime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    weakOBJ(self);
    UITableViewRowAction *remove = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        YTKKeyValueItem *item = MTCSQL.nfKeyValueItems[self.notFocusModelArrM.count-(indexPath.row+1)];
        [MTCSQL.nfStore deleteObjectById:item.itemId fromTable:MTCNOTFOCUSTABLENAME];
        [weak_self.notFocusModelArrM removeObjectAtIndex:indexPath.row];
        if (weak_self.notFocusModelArrM.count) {
            [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
        }else {
            [tableView reloadData];
        }
    }];
    return @[remove];
}

- (NSMutableArray<MTCNotFocusModel *> *)notFocusModelArrM {
    if (!_notFocusModelArrM) {
        _notFocusModelArrM = [NSMutableArray array];
        [MTCSQL.nfKeyValueItems enumerateObjectsUsingBlock:^(YTKKeyValueItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_notFocusModelArrM insertObject:[MTCNotFocusModel yy_modelWithJSON:obj.itemObject] atIndex:0];
        }];
    }
    return _notFocusModelArrM;
}

@end
