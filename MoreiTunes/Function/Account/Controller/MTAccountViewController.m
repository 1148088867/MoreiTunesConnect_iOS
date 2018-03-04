//
//  MTAccountViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTAccountViewController.h"
#import "MTAccountView.h"
#import "MTCreateAccountViewController.h"

@interface MTAccountViewController ()

/** 账户列表 */
psx(MTAccountView, accountView);

@end

@implementation MTAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AccountCenter";
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:UIImageMake(@"添加") tintColor:UIColorWhite position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    MTAccountView *accountView = [[MTAccountView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    selfClass(accountView);
    [self.baseView addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    weakOBJ(self);
    accountView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self.accountView.accountModelArrM removeAllObjects];
        weak_self.accountView.accountModelArrM = nil;
        [weak_self.accountView reloadData];
        [weak_self.progressHUD showAnimated:YES];
        weak_self.progressHUD.label.text = @"数据检测中...";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak_self.accountView.mj_header endRefreshing];
            [weak_self dismissProgressHUD];
        });
    }];
}

- (void)rightBarButtonItemDidClick {
    MTCreateAccountViewController *createAccount = [[MTCreateAccountViewController alloc] init];
    createAccount.title = @"CreateAccount";
    [self.navigationController pushViewController:createAccount animated:YES];
    weakOBJ(self);
    createAccount.createAccountSuccess = ^(MTAccountModel *accountModel) {
        [weak_self.accountView.accountModelArrM insertObject:accountModel atIndex:0];
        [weak_self.accountView reloadData];
    };
}

@end
