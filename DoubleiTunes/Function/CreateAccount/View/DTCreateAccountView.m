//
//  DTCreateAccountView.m
//  DoubleiTunes
//
//  Created by Dwang on 2018/1/19.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "DTCreateAccountView.h"
#import "DTCreateAccountCell.h"

@interface DTCreateAccountView()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) NSArray<NSDictionary *> *createAccountInfoArr;

@end

@implementation DTCreateAccountView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    [self qmui_styledAsQMUITableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.createAccountInfoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    DTCreateAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[DTCreateAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.createAccountInfoArr[indexPath.row];
    NSString *placeholder = dict[@"placeholder"];
    cell.field.tag = 100+indexPath.row;
    cell.field.placeholder = placeholder;
    if ([placeholder isEqualToString:@"请输入Apple ID"]) {
        cell.field.keyboardType = UIKeyboardTypeEmailAddress;
        cell.field.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    }else if ([placeholder isEqualToString:@"请输入登录密码"]) {
        cell.field.secureTextEntry = YES;
    }else {
        cell.field.autocorrectionType = UITextAutocorrectionTypeYes;
    }
    if (self.infos) {
        cell.field.text = self.infos[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (NSArray<NSDictionary *> *)createAccountInfoArr {
    if (!_createAccountInfoArr) {
        _createAccountInfoArr = @[@{@"placeholder":@"请输入Apple ID"},
                                  @{@"placeholder":@"请输入登录密码"},
                                  @{@"placeholder":@"请输入备注信息"}];
    }
    return _createAccountInfoArr;
}

@end
