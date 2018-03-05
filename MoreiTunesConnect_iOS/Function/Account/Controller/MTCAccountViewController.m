//
//  MTCAccountViewController.m
//  MoreiTunes
//
//  Created by Dwang on 2018/1/17.
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "MTCAccountViewController.h"
#import "MTCAccountView.h"
#import "MTCCreateAccountViewController.h"

@interface MTCAccountViewController ()

/** 账户列表 */
psx(MTCAccountView, accountView);

@end

@implementation MTCAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:UIImageMake(@"添加") tintColor:UIColorWhite position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    MTCAccountView *accountView = [[MTCAccountView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
        [weak_self.progressHUD showLoading:@"数据检测中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak_self.accountView.mj_header endRefreshing];
            [weak_self dismissProgressHUD];
        });
    }];
    accountView.infoStr = @"没有更多数据了";
}

- (void)rightBarButtonItemDidClick {
    MTCCreateAccountViewController *createAccount = [[MTCCreateAccountViewController alloc] init];
    createAccount.title = @"CreateAccount";
    [self.navigationController pushViewController:createAccount animated:YES];
    weakOBJ(self);
    createAccount.createAccountSuccess = ^(MTCAccountModel *accountModel) {
        [weak_self.accountView.accountModelArrM insertObject:accountModel atIndex:0];
        [weak_self.accountView reloadData];
    };
}

@end
